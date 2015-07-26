json.array!([@old, @new].flatten) do |book|
  json.extract! book, :name
  json.url book_path(id: book.permalink, format: :json)
end
