class FundingRequestResource < ApplicationRecord
  belongs_to :funding_request
  validates_uniqueness_of :funding_resource_type, scope:[:funding_request]
end
