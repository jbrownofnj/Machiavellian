class CreateTradeRequestResources < ActiveRecord::Migration[7.0]
  def change
    create_table :trade_request_resources do |t|
      t.references :trade_request, null: false, foreign_key: true
      t.string :trade_request_resource_type
      t.integer :trade_request_resource_quantity

      t.timestamps
    end
  end
end
