json.extract! player_resource, :id, :player_id, :resource_quantity, :resource_type, :created_at, :updated_at
json.url player_resource_url(player_resource, format: :json)
