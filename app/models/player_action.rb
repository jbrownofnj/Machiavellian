class PlayerAction < ApplicationRecord
  belongs_to :player
  belongs_to :round
  has_many :raise_armies, dependent: :destroy
  has_many :move_armies, dependent: :destroy
  has_many :gather_informations, dependent: :destroy
  validates_uniqueness_of :action_type, scope: [:round_id,:player_id]
end
