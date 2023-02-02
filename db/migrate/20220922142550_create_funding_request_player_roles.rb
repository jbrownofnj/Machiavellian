class CreateFundingRequestPlayerRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_request_player_roles do |t|
      t.references :player, null: false, foreign_key: true
      t.references :funding_request, null: false, foreign_key: true
      t.string :player_role

      t.timestamps
    end
  end
end
