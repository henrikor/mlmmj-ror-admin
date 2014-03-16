json.array!(@paths) do |path|
  json.extract! path, :path
  json.url path_url(path, format: :json)
end