class CreatePlayerLoyalties < ActiveRecord::Migration[7.0]
  def change
    create_table :player_loyalties do |t|
      t.integer :player_loyalty_quantity

      t.timestamps
    end
  end
end
