class CreateTradeRequestResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :trade_request_responses do |t|
      t.references :trade_player_role, null: false, foreign_key: true
      t.references :trade_request, null: false, foreign_key: true
      t.string :trade_response_type

      t.timestamps
    end
  end
end
