class CreateFundRequestResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :fund_request_responses do |t|
      t.references :funding_request, null: false, foreign_key: true
      t.references :funding_request_player_role, null: false, foreign_key: true
      t.string :funding_request_response_type

      t.timestamps
    end
  end
end
