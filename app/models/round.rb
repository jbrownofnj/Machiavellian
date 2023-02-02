class Round < ApplicationRecord
  belongs_to :match
  has_many :player_actions, dependent: :destroy
  has_many :funding_requests, dependent: :destroy 
  has_many :trade_requests, dependent: :destroy
  has_many :constructions, dependent: :destroy
  
end