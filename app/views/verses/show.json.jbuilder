if @verses.length == 1
  json.number @verses.number
  json.text @verses.text
  json.chapter_url book_chapter_path(book_id: @book.permalink, chapter_id: @verses.chapter_id, format: :json)
else
  json.array! @verses do |verse|
    json.number verse.number
    json.text verse.text
    json.chapter_url book_chapter_path(book_id: @book.permalink, chapter_id: verse.chapter_id, format: :json)
  end
end