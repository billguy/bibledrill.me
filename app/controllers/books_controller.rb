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
    if Rails.env.prodcution?
      @verses = Verse.includes(chapter: :book).where('text ~* ?', params[:q]).order(id: :asc).page params[:page]
    else
      @verses = Verse.includes(chapter: :book).where('text like ?', "%#{params[:q]}%").order(id: :asc).page params[:page]
    end
  end

end