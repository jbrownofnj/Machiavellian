class CreateFundingRequestResources < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_request_resources do |t|
      t.references :funding_request, null: false, foreign_key: true
      t.string :funding_resource_type
      t.integer :funding_resource_amount

      t.timestamps
    end
  end
end
