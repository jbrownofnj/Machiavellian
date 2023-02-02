class CreateMilitaryUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :military_units do |t|
      t.string :military_unit_type, null:false 
      t.integer :military_unit_power,null:false
      t.string :stance,null:false
      t.timestamps
    end
  end
end
