class TradeRequestResponse < ApplicationRecord
  belongs_to :trade_player_role
  belongs_to :trade_request
end
