class PlayerLoyalty < ApplicationRecord
    has_many :player_loyalty_roles, dependent: :destroy
    has_many :players, through: :player_loyalty_roles
    def owner
        @owner=self.player_loyalty_roles.find_by(player_loyalty_role_type: "owner").player
        if @owner.valid?
            @owner
        else
            nil
        end
    end
end
