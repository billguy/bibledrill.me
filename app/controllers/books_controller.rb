class BooksController < KjController

  def index
    @page_title = "King James Bible Books"
    @old = Rails.cache.fetch('old'){ Book.old_testament.to_a }
    @new = Rails.cache.fetch('new'){ Book.new_testament.to_a }
  end

  def show
    @book = Book.find_by_permalink(params[:id])
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    @chapters = @book.chapters
  end

end