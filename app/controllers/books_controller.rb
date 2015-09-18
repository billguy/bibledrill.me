class BooksController < KjController

  def index
    @page_title = "King James Bible"
    @old = Book.old_testament
    @new = Book.new_testament
  end

  def show
    @book = Book.find_by_permalink(params[:id])
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    @chapters = @book.chapters
  end

  def search
    if Rails.env.production?
      @verses = Verse.includes(chapter: :book).where('text ~* ?', '\y%s\y' % params[:q]).order(id: :asc).page params[:page]
    else
      @verses = Verse.includes(chapter: :book).where('text like ?', "%#{params[:q]}%").order(id: :asc).page params[:page]
    end
  end

end