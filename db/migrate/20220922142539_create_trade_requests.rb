class CreateTradeRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :trade_requests do |t|
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
