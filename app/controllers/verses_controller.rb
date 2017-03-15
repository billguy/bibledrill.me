class VersesController < KjController

  before_action :set_book_and_chapter
  protect_from_forgery except: :cross_references

  def index
    @page_title = @chapter.title
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses"
    @verses = @chapter.verses.reorder(id: :asc)
  end

  def show
    @verses = @chapter.verses.where(number: parsed_verses).reorder(id: :asc)
    @highlight_verse_ids = current_user ? current_user.highlights.where(verse_id: @verses.collect(&:id)).pluck(:verse_id) : []
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number} verses", remote: true
    if @verses.length > 1
      @page_title = @chapter.title
      @prev_chapter = @chapter.prev
      @next_chapter = @chapter.next
      add_breadcrumb "Verses", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), remote: true
    else
      @prev_chapter = @verses.first.prev.chapter
      @next_chapter = @verses.first.next.chapter
      @prev_verse = @verses.first.prev
      @next_verse = @verses.first.next
      @page_title = @verses.first.title
      add_breadcrumb "Verse #{@verses.first.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verse #{@verses.first.number}", remote: true
    end
  end

  def cross_references
    @verse = @chapter.verses.where(number: parsed_verses).first
    respond_to do |format|
      format.js
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
      @book = Book.find_by_permalink(params[:book_id])
      @chapter = @book.chapters.find_by_number(params[:chapter_id])
    end

end