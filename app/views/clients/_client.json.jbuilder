json.extract! client, :id, :name, :surname, :business, :phone_number, :email, :created_at, :updated_at
json.url client_url(client, format: :json)
