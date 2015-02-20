json.array!(@approved_users) do |approved_user|
  json.extract! approved_user, :id, :name, :email, :role
  json.url approved_user_url(approved_user, format: :json)
end
