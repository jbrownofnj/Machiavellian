class CreatePlayerLoyaltyRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :player_loyalty_roles do |t|
      t.references :player, null: false, foreign_key: true
      t.references :player_loyalty, null: false, foreign_key: true
      t.string :player_loyalty_role_type

      t.timestamps
    end
  end
end
