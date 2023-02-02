class Construction < ApplicationRecord
  belongs_to :player
  belongs_to :round
  has_many :funding_requests, dependent: :destroy
  has_many :fundings, dependent: :destroy 
  has_many :resource_generator_constructions, dependent: :destroy
  has_many :path_to_power_constructions, dependent: :destroy
  validates_uniqueness_of :player_id, scope: [:round_id]
  
  #returns the amount of a given resource of a certain type
  def has_funding(resource_type)
    amount_of_resource=0
    if self.fundings&.each do |fund|
      if fund.funding_resource_type == resource_type
        amount_of_resource=fund.funding_resource_amount
      end
    end
    end
    amount_of_resource
  end

  def is_funded
    is_funded=false
    if self.construction_type=="resource_generator_construction"
      gold_prices=[1,2,3,4,5]
      amount_already_constructed=self.player.resource_generators.where(resource_generator_type:self.resource_generator_constructions.first.resource_generator_type).count
      if amount_already_constructed > 4
        amount_already_constructed=4
      end
      gold_cost=gold_prices[amount_already_constructed]
      
      if self.fundings.count>0
        if self.fundings.first.funding_resource_amount >= gold_cost
          is_funded=true
        end
      end
    end
    is_funded
  end
end
