class FundRequestResponse < ApplicationRecord
  belongs_to :funding_request
  belongs_to :funding_request_player_role
end
