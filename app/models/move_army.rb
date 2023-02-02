class MoveArmy < ApplicationRecord
  belongs_to :player
  belongs_to :player_action
  belongs_to :military_unit
end
