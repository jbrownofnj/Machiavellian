class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.string :house_name
      t.integer :victory_points, null:false, default:0
      t.timestamps
    end
  end
end
