class MilitaryUnit < ApplicationRecord
    has_many :player_military_unit_roles, dependent: :destroy
    has_many :move_armies, dependent: :destroy
    has_many :players, through: :player_military_unit_roles
    def owner
        @owner=self.player_military_unit_roles.find_by(military_unit_role_type: "owner")&.player || nil
    end
    def houser
        @houser=self.player_military_unit_roles.find_by(military_unit_role_type: "houser").player
        if @houser.valid?
            @houser
        else
            nil
        end
    end
end
