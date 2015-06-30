json.array!(@quotes) do |quote|
  json.extract! quote, :id, :text, :author, :source, :char_length, :category
  json.url quote_url(quote, format: :json)
end
