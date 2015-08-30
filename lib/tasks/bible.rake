require 'render_anywhere' if Rails.env.development?

namespace :bible do

  include RenderAnywhere if Rails.env.development?

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

  desc "Renumber pages"
  task renumber_pages: :environment do
    max_words_per_page = 400 #configure this
    current_page, current_word_count = 1, 0
    Verse.find_each do |verse|
      current_word_count += verse.text.split.length
      if current_word_count > max_words_per_page
        current_word_count = 0
        current_page += 1
      end
      verse.update_column(:page, current_page)
    end
  end

  desc "Rebuild html"
  task rebuild_html: :environment do
    template = render(partial: 'drills/index')
    File.open(Rails.root.join('app', 'views', 'drills', 'index.html').to_s, "w+") do |f|
      f.write(template)
    end
  end

end