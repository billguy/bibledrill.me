json.number @chapter.number
json.book_url book_path(@chapter.book_permalink, format: :json)
json.verses @verses do |verse|
  json.url book_chapter_verse_path(book_id: @book.permalink, chapter_id: @chapter.number, id: verse.number, format: :json)
end