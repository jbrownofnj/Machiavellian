json.extract! funding_request_resource, :id, :funding_request_id, :funding_resource_type, :funding_resource_amount, :created_at, :updated_at
json.url funding_request_resource_url(funding_request_resource, format: :json)
