class FundingRequestPlayerRole < ApplicationRecord
  belongs_to :player
  belongs_to :funding_request
  has_many :fund_request_responses, dependent: :destroy
  validates_uniqueness_of :player_role, scope:[:player,:funding_request]
end
