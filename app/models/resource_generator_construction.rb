class ResourceGeneratorConstruction < ApplicationRecord
  belongs_to :construction
  validates_uniqueness_of :construction_id

  def cost_to_fund_in_gold
    gold_prices=[1,2,3,4,5]
      amount_already_constructed=self.construction.player.resource_generators.where(resource_generator_type:self.construction.resource_generator_constructions.first.resource_generator_type).count
      if amount_already_constructed > 4
        amount_already_constructed=4
      end
      gold_cost=gold_prices[amount_already_constructed]
  end    
end
