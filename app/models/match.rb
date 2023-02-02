class Match < ApplicationRecord
  belongs_to :game
  has_many :player_match_roles, dependent: :destroy
  has_many :players, through: :player_match_roles
  has_many :rounds, dependent: :destroy
  
  def is_over()
    is_over=false
    funded_paths_to_power=0
    self.game.players.each do |player|
      player.constructions&.each do |construction|
        if construction.construction_type=="path_to_power_construction"
          if construction.path_to_power_constructions.first.is_funded()
            funded_paths_to_power+=1
          end
        end
      end
    end
    if funded_paths_to_power>1
      self.game.players.each do |player|
        if player.constructions&.each do |construction|
          if construction.construction_type=="path_to_power_construction"
            if construction.path_to_power_constructions.first.is_funded
              construction.destroy!
            end
          end
        end
        end
      end
    elsif funded_paths_to_power==1
      is_over=true
    end
    is_over
  end

  def winner
    winner=nil
    self.game.players.each do |player|
      if player.constructions&.each do |construction|
        if construction.construction_type == "path_to_power_construction"
          if construction.path_to_power_constructions.first.is_funded
            winner=construction.player
          end
        end
      end
      end
    end
    winner
  end
end
