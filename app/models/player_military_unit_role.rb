class PlayerMilitaryUnitRole < ApplicationRecord
  belongs_to :player
  belongs_to :military_unit
end
