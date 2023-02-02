class CreateRaiseArmies < ActiveRecord::Migration[7.0]
  def change
    create_table :raise_armies do |t|
      t.integer :army_power
      t.string :raise_army_type, null:false, defualt:"army"
      t.references :player_action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
