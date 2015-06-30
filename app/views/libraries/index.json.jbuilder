json.array!(@libraries) do |library|
  json.extract! library, :id
  json.url library_url(library, format: :json)
end
