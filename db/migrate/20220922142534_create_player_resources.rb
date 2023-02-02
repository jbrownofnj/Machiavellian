class CreatePlayerResources < ActiveRecord::Migration[7.0]
  def change
    create_table :player_resources do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :resource_quantity
      t.string :resource_type

      t.timestamps
    end
  end
end
