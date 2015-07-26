json.array! @verses do |verse|
  json.number verse.number
  json.verse_url book_chapter_verse_path(book_id: @book.permalink, chapter_id: verse.chapter_number, id: verse.number, format: :json)
end