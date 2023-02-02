class CreateResourceGenerators < ActiveRecord::Migration[7.0]
  def change
    create_table :resource_generators do |t|
      t.references :player, null: false, foreign_key: true
      t.string :resource_generator_type

      t.timestamps
    end
  end
end
