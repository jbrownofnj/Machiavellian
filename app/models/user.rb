class User < ApplicationRecord
    has_secure_password
    has_many :players 
    has_many :games, through: :players
    has_many :user_game_roles
    validates_uniqueness_of :user_email
    validates_format_of :user_email, with: URI::MailTo::EMAIL_REGEXP
    validate :password_lower_case
    validate :password_uppercase
    validate :password_special_char
    validate :password_contains_number
    validate :password_length

    def password_length
        return if password.length>7
        errors.add :password, " Your password needs to be at least 8 characters long"
    end

    def password_uppercase
        return if !!password.match(/\p{Upper}/)
        errors.add :password, ' Your password needs at least one uppercase letter '
    end

    def password_lower_case
        return if !!password.match(/\p{Lower}/)
        errors.add :password, ' Your password needs at least one lowercase letter '
    end

    def password_special_char
        special = "?<>',?[]}{=-)(*&@^%$#`~{}!"
        regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
        return if password =~ regex
        errors.add :password, ' Your password needs at least one special character '
    end

    def password_contains_number
        return if password.count("0-9") > 0
        errors.add :password, ' Your password needs at least one number '
    end


    def make_example_game()
        @testuser2=User.find_by(user_email:"testuser2@gmail.com")
        @testuser3=User.find_by(user_email:"testuser3@gmail.com")
        @testuser4=User.find_by(user_email:"testuser4@gmail.com")
        @testuser5=User.find_by(user_email:"testuser5@gmail.com")
        @testuser6=User.find_by(user_email:"testuser6@gmail.com")
        if self.user_email.include? "testuser"
        elsif @testuser2 && @testuser3 && @testuser4 && @testuser5 && @testuser6
            @game=Game.create(game_name:"example game for #{self.user_email}",password:"examplegame")
            @match=Match.create(game:@game)
            @round1=Round.create(match:@match)
            @player=Player.create(user:self,house_name:"Your House Name",game:@game)
            @player2=Player.create(user:@testuser2,house_name:"Your tallest friend",game:@game)
            @player3=Player.create(user:@testuser3,house_name:"Your loudest friend",game:@game) 
            @player4=Player.create(user:@testuser4,house_name:"Your nicest friend",game:@game) 
            @player5=Player.create(user:@testuser5,house_name:"Your strangest friend",game:@game) 
            @player6=Player.create(user:@testuser6,house_name:"Your oldest friend",game:@game)
            @player_gold=PlayerResource.create(resource_type:"gold",resource_quantity:4,player:@player)
            @player_soldier=PlayerResource.create(resource_type:"soldier",resource_quantity:2,player:@player)
            @player_spy=PlayerResource.create(resource_type:"spy",resource_quantity:3,player:@player)
            @player_mine1=ResourceGenerator.create(resource_generator_type:"mine",player:@player)
            @player_mine2=ResourceGenerator.create(resource_generator_type:"mine",player:@player)
            @player_castle=ResourceGenerator.create(resource_generator_type:"castle",player:@player)
            @player_embassy=ResourceGenerator.create(resource_generator_type:"embassy",player:@player)
            @player_army2=MilitaryUnit.create(military_unit_type:"army",military_unit_power:2,stance:"defense")
            @player_owns_army2=PlayerMilitaryUnitRole.create(player:@player,military_unit:@player_army2,military_unit_role_type:"owner")
            @player_houses_army2=PlayerMilitaryUnitRole.create(player:@player,military_unit:@player_army2,military_unit_role_type:"houser")  
            @player_army4=MilitaryUnit.create(military_unit_type:"army",military_unit_power:4,stance:"defense")
            @player_owns_army2=PlayerMilitaryUnitRole.create(player:@player,military_unit:@player_army4,military_unit_role_type:"owner")
            @player_houses_army2=PlayerMilitaryUnitRole.create(player:@player3,military_unit:@player_army4,military_unit_role_type:"houser")  
            @player_loyalty=PlayerLoyalty.create(player_loyalty_quantity:45)
            @player2_loyalty=PlayerLoyalty.create(player_loyalty_quantity:10)
            @player_holds_loyalty1=PlayerLoyaltyRole.create(player:@player,player_loyalty_role_type:"holder",player_loyalty:@player_loyalty)
            @player_owns_loyalty1=PlayerLoyaltyRole.create(player:@player,player_loyalty_role_type:"owner",player_loyalty:@player_loyalty)
            @player_holds_loyalty2=PlayerLoyaltyRole.create(player:@player,player_loyalty_role_type:"holder",player_loyalty:@player2_loyalty)
            @player2_owns_loyalty2=PlayerLoyaltyRole.create(player:@player2,player_loyalty_role_type:"owner",player_loyalty:@player2_loyalty)
            @construction_castle=Construction.create(player:@player,construction_type:"resource_generator_construction",round:@round1)
            @resource_generator_construction_castle=ResourceGeneratorConstruction.create(resource_generator_type:"castle",construction:@construction_castle)
            @round2=Round.create(match:@match)
            @round3=Round.create(match:@match)
            @round4=Round.create(match:@match)
            @round5=Round.create(match:@match)
            @round6=Round.create(match:@match)
            @round7=Round.create(match:@match)
            @funding_request=FundingRequest.create(round:@round7,construction:@construction_castle)
            @player_giving_funds_role=FundingRequestPlayerRole.create(funding_request:@funding_request,player:@player2,player_role:"funder")
            @player_accepting_funds_role=FundingRequestPlayerRole.create(funding_request:@funding_request,player:@player,player_role:"owner")
            @gold_for_funding_request=FundingRequestResource.create(funding_resource_amount:2, funding_resource_type:"gold", funding_request:@funding_request)
            @trade_request=TradeRequest.create(round:@round7)
            @player_giving_resources_role=TradePlayerRole.create(trade_request:@trade_request,role_type:"sender",player:@player2)
            @player_creating_trade_role=TradePlayerRole.create(trade_request:@trade_request,role_type:"creator",player:@player)
            @trade_request_spies=TradeRequestResource.create(trade_request:@trade_request, trade_request_resource_quantity:2,trade_request_resource_type:"gold")
        else  
        end

    end

    def has_no_unfinished_games?
        self.games&.each do |game|
            if game.finished==false
                return false
            end
        end
        return true
    end
end
