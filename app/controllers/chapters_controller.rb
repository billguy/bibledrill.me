class ChaptersController < KjController

  before_action :set_book

  def index
    @page_title = @book.name
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapters", nil, title: "Chapters"
    @chapters = Rails.cache.fetch("books/#{@book.permalink}/chapters"){ @book.chapters.to_a }
  end

  def show
    @chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:id]}"){ @book.chapters.find_by_number(params[:id]) }
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses", nil, title: "Verses"
    @page_title = @chapter.title
    @verses = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:id]}/verses"){ @chapter.verses.to_a }
    @prev_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:id]}/prev") { @chapter.prev }
    @next_chapter = Rails.cache.fetch("books/#{@book.permalink}/chapters/#{params[:id]}/next") { @chapter.next }
  end

  private

    def set_book
      @book =  Rails.cache.fetch("books/#{params[:book_id]}"){ Book.find_by_permalink(params[:book_id]) }
    end

end