class TradePlayerRole < ApplicationRecord
  belongs_to :player
  belongs_to :trade_request
  has_many :trade_request_responses, dependent: :destroy
  validates_each :role_type do |record, attr, value|
    if value=="creator" && record.player.own_trade_requests_this_round.count>=3
      record.errors.add(attr, 'Sorry you can only have 3 trades in a round')
    end
  end
end
