class PlayerLoyaltyRole < ApplicationRecord
  belongs_to :player
  belongs_to :player_loyalty
end
