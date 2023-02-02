class CreateFundings < ActiveRecord::Migration[7.0]
  def change
    create_table :fundings do |t|
      t.references :construction, null: false, foreign_key: true
      t.string :funding_resource_type
      t.integer :funding_resource_amount

      t.timestamps
    end
  end
end
