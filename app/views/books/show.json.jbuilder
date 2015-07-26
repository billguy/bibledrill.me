json.extract! @book, :name, :permalink
json.chapters @chapters do |chapter|
  json.url book_chapter_path(book_id: @book.permalink, id: chapter.number, format: :json)
end