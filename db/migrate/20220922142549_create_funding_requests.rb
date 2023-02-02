class CreateFundingRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_requests do |t|
      t.references :round, null: false, foreign_key: true
      t.references :construction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
