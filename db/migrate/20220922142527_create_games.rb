class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :game_name
      t.string :password_digest, null:false
      t.boolean :finished,default:false
      t.timestamps
    end
  end
end
