class CreatePlayerMilitaryUnitRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :player_military_unit_roles do |t|
      t.references :player, null: false, foreign_key: true
      t.references :military_unit, null: false, foreign_key: true
      t.string :military_unit_role_type
      t.timestamps
    end
  end
end
