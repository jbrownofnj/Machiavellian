class CreateGatherInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :gather_informations do |t|
      t.references :player_action, null: false, foreign_key: true
      t.references :player,null: false, foreign_key:true
      t.string :information_type


      t.timestamps
    end
  end
end
