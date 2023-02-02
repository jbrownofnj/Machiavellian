class RaiseArmy < ApplicationRecord
  belongs_to :player_action
  validates_uniqueness_of :player_action_id
  validates :army_power, numericality:{only_integer: true}
  validates :army_power, numericality:{greater_than:0}
end
