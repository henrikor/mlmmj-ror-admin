json.array!(@changes) do |change|
  json.extract! change, :user_id, :list_id, :added_adresses, :removed_adresses
  json.url change_url(change, format: :json)
end