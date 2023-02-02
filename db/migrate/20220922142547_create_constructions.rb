class CreateConstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :constructions do |t|
      t.references :player, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true
      t.string :construction_type

      t.timestamps
    end
  end
end
