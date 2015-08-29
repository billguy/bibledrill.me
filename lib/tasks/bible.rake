namespace :bible do
  desc "Build book/vhapter/verse models from the kj gem"
  task build: :environment do
    bible = Kj::Bible.new
    bible.books.each do |b|
      book = Book.create(name: b.name, permalink: b.permalink, abbreviations: b.abbreviations.split(','))
      b.chapters.each do |c|
        chapter = Chapter.create(book_id: book.id, number: c.number)
        c.verses.each do |v|
          Verse.create(chapter_id: chapter.id, number: v.number, text: v.text, page: v.page)
        end
      end
    end
  end

end