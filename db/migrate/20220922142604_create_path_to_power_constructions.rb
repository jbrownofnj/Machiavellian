class CreatePathToPowerConstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :path_to_power_constructions do |t|
      t.references :construction, null: false, foreign_key: true
      t.string :path_to_power_type

      t.timestamps
    end
  end
end
