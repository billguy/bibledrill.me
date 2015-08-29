class VersesController < KjController

  before_action :set_book_and_chapter

  def index
    @page_title = @chapter.title
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses"
    @verses = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/verses"){ @chapter.verses.to_a }
  end

  def show
    @verses = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/verses/#{parsed_verses.join(',')}"){ @chapter.verses.where(number: parsed_verses).to_a }
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number} verses", remote: true
    if @verses.length > 1
      @page_title = @chapter.title
      @prev_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/prev") { @chapter.prev }
      @next_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/next") { @chapter.next }
      add_breadcrumb "Verses", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), remote: true
    else
      @prev_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/prev") { @verses.first.prev.chapter }
      @next_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/next") { @verses.first.next.chapter }
      @prev_verse = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/verses/#{@verses.first.number}/prev") { @verses.first.prev }
      @next_verse = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}/verses/#{@verses.first.number}/next") { @verses.first.next }
      @page_title = @verses.first.title
      add_breadcrumb "Verse #{@verses.first.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verse #{@verses.first.number}", remote: true
    end
  end

  private

    def parsed_verses
      verses = params[:id].gsub(/\s+/, "")
      single_verses = verses.split(',').reject{|verse| verse =~ /\d{1,}\-\d{1,}/ }.map(&:to_i)
      ranges = verses.scan(/\d{1,}\-\d{1,}/).map{|range| Range.new(*range.split("-").map(&:to_i)).to_a }
      [single_verses, ranges].flatten.compact
    end

    def set_book_and_chapter
      @book =  Rails.cache.fetch("books/#{params[:book_id]}"){ Book.find_by_permalink(params[:book_id]) }
      @chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:chapter_id]}"){ @book.chapters.find_by_number(params[:chapter_id]) }
    end

end