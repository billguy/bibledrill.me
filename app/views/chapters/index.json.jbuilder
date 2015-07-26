json.array!(@chapters) do |chapter|
  json.extract! chapter, :number
  json.url book_chapter_path(book_id: @book.permalink, id: chapter.number, format: :json)
end
