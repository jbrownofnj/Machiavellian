class CreatePlayerMatchRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :player_match_roles do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :player_match_role_type

      t.timestamps
    end
  end
end
