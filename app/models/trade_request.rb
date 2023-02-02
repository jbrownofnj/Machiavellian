class TradeRequest < ApplicationRecord
  belongs_to :round
  has_many :trade_request_responses, dependent: :destroy
  has_many :trade_request_resources, dependent: :destroy
  has_many :trade_player_roles, dependent: :destroy
  has_many :players, through: :trade_player_roles
  accepts_nested_attributes_for :trade_player_roles
  accepts_nested_attributes_for :trade_request_resources
  accepts_nested_attributes_for :players
  accepts_nested_attributes_for :trade_request_responses, allow_destroy: true
  


  def creator
    self.trade_player_roles.each do |role|
      if role.role_type=="creator"
       @creator=role.player
      end
    end
    @creator
  end
  def sender
    @sender=nil
    self.trade_player_roles.each do |role|
      if role.role_type=="sender"
       @sender=role.player
      end
    end
    @sender
  end
  def receiver
    @receiver=nil
    self.trade_player_roles.each do |role|
      if role.role_type=="receiver"
       @receiver=role.player
      end
    end
    @receiver
  end

  def trade_target_role
    @role=nil
    self.trade_player_roles.each do |role|
      if (role.role_type == "sender" || role.role_type=="receiver") && role.player != role.trade_request.creator
        @role=role
      end
    end
    @role
  end

  def is_not_accepted
    @is_not_accepted=true
    self.trade_request_responses&.each do |response|
      if response.trade_response_type == "accept"
        @is_not_accepted=false
      end
    end
    @is_not_accepted
  end

  def is_accepted
    @is_accepted=false
    self.trade_request_responses&.each do |response|
      if response.trade_response_type == "accept"
        @is_accepted=true
      end
    end
    @is_accepted
  end

  def payout
    self.trade_request_resources&.each do |resource|
      if resource.trade_request_resource_type.include? "loyalty"
        self.sender.lose_loyalty(Player.find_by(house_name:resource.trade_request_resource_type.slice(0,resource.trade_request_resource_type.index("loyalty")-1)),resource.trade_request_resource_quantity)
        self.receiver.get_loyalty(Player.find_by(house_name:resource.trade_request_resource_type.slice(0,resource.trade_request_resource_type.index("loyalty")-1)),resource.trade_request_resource_quantity)
      else
        self.sender.lose_resource(resource.trade_request_resource_type.downcase,resource.trade_request_resource_quantity)
        self.receiver.get_resource(resource.trade_request_resource_type.downcase,resource.trade_request_resource_quantity)
      end
    end
  end
  def unresponded_to?
    @unresponded_to=true
    self.trade_request_responses&.each do |response|
      @unresponded_to=false
    end
    @unresponded_to
  end
  def is_rejected?
    @rejected=false
    self.trade_request_responses&.each do |response|
      if response.trade_response_type=="reject"
        @rejected=true
      end
    end
    @rejected
  end
end
