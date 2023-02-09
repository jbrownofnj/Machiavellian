class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :player_match_roles, dependent: :destroy
  has_many :matches, through: :player_match_roles
  has_many :player_actions, dependent: :destroy
  has_many :player_resources, dependent: :destroy
  has_many :player_loyalty_roles, dependent: :destroy
  has_many :player_loyalties, through: :player_loyalty_roles
  has_many :trade_player_roles, dependent: :destroy
  has_many :trade_request_resources, through: :trade_player_roles
  has_many :player_military_unit_roles, dependent: :destroy
  has_many :military_units, through: :player_military_unit_roles
  has_many :constructions , dependent: :destroy
  has_many :resource_generators, dependent: :destroy
  has_many :funding_request_player_roles, dependent: :destroy
  has_many :funding_requests, through: :funding_request_player_roles
  validates_uniqueness_of :house_name, scope: [:game_id]
  validates_uniqueness_of :user, scope: [:game_id]

  def owns_loyalty
    owns_loyalty=false
    self.player_loyalty_roles&.each do |role|
      if role.player_loyalty_role_type == "holder"
        owns_loyalty=true
      end
    end
    owns_loyalty
  end 

  def how_much_loyalty(house_name)
    @amount_held=0
    self.player_loyalty_roles&.each do |role|
      if role.player_loyalty_role_type== "holder" && role.player_loyalty.owner.house_name==house_name
        @amount_held=role.player_loyalty.player_loyalty_quantity
      end
    end
    @amount_held
  end

  def lose_loyalty(player_to_lose_from,amount_loyalty_to_lose)
    if self.how_much_loyalty(player_to_lose_from.house_name)>0
      self.player_loyalty_roles.each do |role|
        if role.player_loyalty_role_type == "holder" && role.player_loyalty.owner==player_to_lose_from
        
          if role.player_loyalty.player_loyalty_quantity>amount_loyalty_to_lose
            role.player_loyalty.update(player_loyalty_quantity:role.player_loyalty.player_loyalty_quantity-amount_loyalty_to_lose)
          else
            role.player_loyalty.destroy
          end
        end
      end
    else
      @new_loyalty=PlayerLoyalty.new(player_loyalty_quantity:amount_loyalty_to_gain)
      if @new_loyalty.save
        @holder=PlayerLoyaltyRole.new(player:self,player_loyalty:@new_loyalty,player_loyalty_role_type:"holder")
        @owner=PlayerLoyaltyRole.new(player:player_to_get_from,player_loyalty:@new_loyalty,player_loyalty_role_type:"owner")
        if @holder.save && @owner.save
        else
          @new_loyalty.destroy
        end
      else
      end
    end
  end
  
  def get_loyalty(player_to_get_from,amount_loyalty_to_gain)
    if self.how_much_loyalty(player_to_get_from.house_name)>0
      self.player_loyalty_roles.each do |role|
        if role.player_loyalty_role_type == "holder" && role.player_loyalty.owner==player_to_get_from
          role.player_loyalty.update(player_loyalty_quantity:role.player_loyalty.player_loyalty_quantity+amount_loyalty_to_gain)
        end
      end
    else
      @new_loyalty=PlayerLoyalty.new(player_loyalty_quantity:amount_loyalty_to_gain)
      if @new_loyalty.save
        @holder=PlayerLoyaltyRole.new(player:self,player_loyalty:@new_loyalty,player_loyalty_role_type:"holder")
        @owner=PlayerLoyaltyRole.new(player:player_to_get_from,player_loyalty:@new_loyalty,player_loyalty_role_type:"owner")
        if @holder.save && @owner.save
        else
          @new_loyalty.destroy
        end
      else
      end
    end
  end

  def get_resource(resource_type,resource_amount)
    if self.player_resources.where(resource_type:resource_type)
      @player_resource=self.player_resources.find_by(resource_type:resource_type)
      @player_resource.update(resource_quantity:@player_resource.resource_quantity+resource_amount)
    else
      @new_resource=PlayerResource.create(resource_type:resource_type,resource_quantity:resource_amount,player:self)
    end
  end

  def lose_resource(resource_type,resource_amount)

    if self.player_resources.where(resource_type:resource_type).count>0
      if self.player_resources.find_by(resource_type:resource_type).resource_quantity > resource_amount
        @player_resource=self.player_resources.find_by(resource_type:resource_type)
        @player_resource.update(resource_quantity:@player_resource.resource_quantity-resource_amount)
      else
        self.player_resources.find_by(resource_type:resource_type).destroy
      end
    end
  end

  def is_not_routed
    @attacking_units_power=0
    @defending_units_power=0
    @is_not_routed=true
    self.player_military_unit_roles&.each do |role|
      if role.military_unit_role_type == "houser" && role.military_unit.stance == "defending"
        @defending_units_power += role.military_unit.military_unit_power
      elsif role.military_unit_role_type == "houser" && role.military_unit.stance == "attacking" && role.military_unit.owner != self
        @attacking_units_power += role.military_unit.military_unit_power
      end
    end
    @is_not_routed=@defending_units_power >= @attacking_units_power
  end
  
  def has_enough_resource(resource_type,resource_amount)
    @has_enough=true
    if self.player_resources.exists?(resource_type:resource_type)
      if self.player_resources.find_by(resource_type:resource_type).resource_quantity < resource_amount
        @has_enough=false
      end
    else
      @has_enough=false
    end
    @has_enough
  end

  def amount_of_resource(resource_type)
    amount=0
    resource=self.player_resources.find_by(resource_type:resource_type)||nil
    if resource
      amount=resource.resource_quantity
    end
    amount
  end

  def cost_to_gather_information(round)
    latest_match=self.game.matches.last
    times_gathered_this_match=0
    latest_match.rounds.each do |round|
      times_gathered_this_round=round.player_actions.where(action_type:"gather_information",player: self).count
      times_gathered_this_match+=times_gathered_this_round
    end
    cost=times_gathered_this_match+1
  end

  def own_military_units
    @own_military_units=[]
    self.military_units&.each do |military_unit|
      if military_unit.owner==self
        @own_military_units.push(military_unit)
      end
    end
    @own_military_units
  end

  def has_military_units?
    has_military_units=false
    self.player_military_unit_roles&.each do |military_unit_role|
      if military_unit_role.military_unit_role_type=="owner"
        has_military_units=true
      end
    end
    has_military_units
  end

  def own_loyalty
    @own_loyalty=[]
    self.player_loyalty_roles&.each do |player_loyalty_role|
      if player_loyalty_role.player_loyalty.owner==self
        @own_loyalty.push(player_loyalty_role.player_loyalty)
      end
    end
    @own_loyalty
  end

  def own_trade_requests
    @own_trade_requests=[]
    self.trade_player_roles&.each do |role|
      if role.role_type=="creator"
        @own_trade_requests.push(role.trade_request)
      end
    end
    @own_trade_requests
  end

  def own_trade_requests_this_round
    @own_trade_requests_this_round=[]
    self.trade_player_roles&.each do |role|
      if role.role_type=="creator" && role.trade_request.round==self.game.current_round
        @own_trade_requests_this_round.push(role.trade_request)
      end
    end
    @own_trade_requests_this_round
  end

  def can_afford_trade?(trade_request)
    trade_request.trade_request_resources&.each do |trade_request_resource|
      if self.player_resources
        if trade_request_resource.trade_request_resource_type.include?"loyalty"
          ammount_of_loyalty=self.how_much_loyalty(trade_request_resource.trade_request_resource_type.slice(0,trade_request_resource.trade_request_resource_type.index("loyalty")-1))
          if ammount_of_loyalty<trade_request_resource.trade_request_resource_quantity
            return false
          end
        else
          needed_resource=self.player_resources.where(resource_type:trade_request_resource.trade_request_resource_type).first
          if needed_resource
            if needed_resource.resource_quantity<trade_request_resource.trade_request_resource_quantity
              return false
            end
          else
            return false
          end
        end
      else 
        return false
      end
    end
    return true
  end

  def can_ask_for_funding?
    can_ask_for_funding=true
    current_round=self.game.current_round
    @funding_requests_requests_this_round=self.funding_requests&.where(round:current_round)
    @amount_funding_requests_this_round=@funding_requests_requests_this_round.count
    @amount_of_unfunded_constructions=0
    self.constructions&.each do |construction|
      if construction.is_funded==false
        @amount_of_unfunded_constructions+=1
      end
    end
    if @amount_funding_requests_this_round >= (self.game.players.count-1)*@amount_of_unfunded_constructions  || @amount_of_unfunded_constructions==0
      can_ask_for_funding=false
    end
    can_ask_for_funding
  end

  def has_unfunded_constructions?
    self.constructions&.each do |construction|
      if construction.is_funded==false && construction.funded==false
        return true
      end
    end
    false
  end

  def unfunded_constructions
    undfunded_construcitons=[]
    self.constructions&.each do |construction|
      if construction.is_funded
        unfunded_constructions.push(construction)
      end
    end
  end
  
  def has_moved_a_military_unit_this_round?
    current_round=self.game.current_round
    current_round.player_actions&.where(player:self,action_type:"move_army").count>0
  end

  def has_raised_army_this_round?
    current_round=self.game.current_round
    current_round.player_actions&.where(player:self,action_type:"raise_army").count>0
  end
  
  def has_gathered_information_this_round?
    self.player_actions&.where(action_type:"gather_information",round:self.game.current_round).count>0
  end

  def has_trades_last_round?
    has_trades_last_round=false
    if self.game.matches.last.rounds.count==1
      return false
    else
      last_round=self.game.matches.last.rounds.second_to_last
      self.trade_player_roles&.each do |role|
        if role.trade_request.is_accepted && role.trade_request.round==last_round
          has_trades_last_round=true
        end
      end
    end
    has_trades_last_round
  end

  def has_no_constructions_of_type?(new_construction)
    unique=true
    self.constructions&.each do |construction|
      ##checks if construction exists and its not funded by db and also by the is_funded function. This is needed
      #so that the constructions that have already been funded are not counted from previous rounds when funding them was
      #cheaper.
      if (construction.construction_type == new_construction.construction_type) && construction.is_funded == false && construction.funded==false
        unique=false
      end
    end
    unique
  end

end