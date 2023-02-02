class CreateResourceGeneratorConstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :resource_generator_constructions do |t|
      t.references :construction, null: false, foreign_key: true
      t.string :resource_generator_type

      t.timestamps
    end
  end
end
