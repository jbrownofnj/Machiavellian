json.extract! player, :id, :user_id, :game_id, :house_name, :created_at, :updated_at
json.url player_url(player, format: :json)
