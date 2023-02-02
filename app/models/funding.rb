class Funding < ApplicationRecord
  belongs_to :construction
  validates_uniqueness_of :funding_resource_type,scope:[:construction]
end
