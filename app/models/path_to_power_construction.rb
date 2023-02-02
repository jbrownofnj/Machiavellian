class PathToPowerConstruction < ApplicationRecord
  belongs_to :construction
  validates_uniqueness_of :construction_id

  def is_funded()
    @is_funded=false
    # sets the cost of the path to power construction
    case self.path_to_power_type.downcase
    when "war"
      soldier_goal=10
      gold_goal=5
      spy_goal=3
    when "wealth"
      gold_goal=10
      spy_goal=5
      soldier_goal=3
    when "subterfuge"
      spy_goal=10
      soldier_goal=5
      gold_goal=3
    else
      spy_goal=100
      soldier_goal=100
      gold_goal=100
    end
    if self.construction.has_funding("gold") >= gold_goal && self.construction.has_funding("spy") >= spy_goal && self.construction.has_funding("soldier") >= soldier_goal
      @is_funded=true
    end
    @is_funded
  end

  
  def gold_cost
    gold_cost=100
    case self.path_to_power_type
    when "war"
      gold_cost=5
    when "wealth"
      gold_cost=10
    when "subterfuge"
      gold_cost=3
    end
    gold_cost
  end

  def spy_cost
    spy_cost=100
    case self.path_to_power_type
    when "war"
      spy_cost=3
    when "wealth"
      spy_cost=5
    when "subterfuge"
      spy_cost=10
    end
    spy_cost
  end

  def soldier_cost
    soldier_cost=100
    case self.path_to_power_type
    when "war"
      soldier_cost=10
    when "wealth"
      soldier_cost=3
    when "subterfuge"
      soldier_cost=5
    end
  end

end
