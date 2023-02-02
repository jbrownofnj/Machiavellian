class CreateMoveArmies < ActiveRecord::Migration[7.0]
  def change
    create_table :move_armies do |t|
      t.references :player, null: false, foreign_key: true
      t.references :player_action, null: false, foreign_key: true
      t.references :military_unit, null: false, foreign_key: true
      t.string :stance_command,null:false
      t.timestamps
    end
  end
end
