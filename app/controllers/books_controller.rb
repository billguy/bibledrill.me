class BooksController < KjController

  def index
    @page_title = "King James Bible"
    @old = Rails.cache.fetch('books/old'){ Book.old_testament.to_a }
    @new = Rails.cache.fetch('books/new'){ Book.new_testament.to_a }
  end

  def show
    @book = Rails.cache.fetch("books/#{params[:id]}"){ Book.find_by_permalink(params[:id]) }
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    @chapters = Rails.cache.fetch("books/#{@book.permalink}/chapters"){ @book.chapters.to_a }
  end

  def search
    @verses = Verse.includes(chapter: :book).search_by_text(params[:q]).page params[:page]
  end

end