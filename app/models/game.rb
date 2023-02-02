class Game < ApplicationRecord
    has_many :user_game_roles
    has_many :matches, dependent: :destroy
    has_many :players, dependent: :destroy
    has_secure_password
    accepts_nested_attributes_for :players, allow_destroy: true
    validates_uniqueness_of :game_name
    def clear_for_new_match
        self.players.each do |player|
            player.player_resources.destroy_all
            player.own_military_units.each do |military_unit|
                military_unit.destroy
            end
            player.resource_generators.destroy_all
            player.own_loyalty.each do |player_loyalty|
                player_loyalty.destroy
            end
            player.constructions.destroy_all
            player.own_trade_requests.each do |trade_request|
                trade_request.destroy
            end
            player_loyalty=PlayerLoyalty.create(player_loyalty_quantity:100)
            player_loyalty_role_holder=PlayerLoyaltyRole.create(player_loyalty_role_type:"holder",player:player,player_loyalty:player_loyalty)
            player_loyalty_role_owner=PlayerLoyaltyRole.create(player_loyalty_role_type:"owner",player:player,player_loyalty:player_loyalty)
            first_mine=ResourceGenerator.create(resource_generator_type:"mine",player:player)
            first_gold=PlayerResource.create(player:player,resource_quantity:1,resource_type:"gold")
    
        end
    end

    def is_over
        is_over=false
        self.players.each do |player|
            if player.victory_points >=60
                is_over=true
            end
        end
        is_over
    end
    def winners
        winners=[]
        peak_points=0
        self.players.each do |player|
            if player.victory_points >= 60 && player.victory_points > peak_points
                winners.clear()
                winners.push(player)
            elsif player.victory_points > 60 && player.victoy_points == peak_points
                winners.push(player)
            end
        end
        winners
    end
    def current_round
        self.matches.last.rounds.last
    end
end
