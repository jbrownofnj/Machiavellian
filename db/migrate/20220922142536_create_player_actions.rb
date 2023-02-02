class CreatePlayerActions < ActiveRecord::Migration[7.0]
  def change
    create_table :player_actions do |t|
      t.references :player, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true
      t.string :action_type

      t.timestamps
    end
  end
end
