class BooksController < KjController

  def index
    @page_title = "King James Bible"
    @old = Book.old_testament
    @new = Book.new_testament
    @higlights = current_user ? current_user.highlights.order(verse_id: :asc) : []
  end

  def show
    @book = Book.find_by_permalink(params[:id])
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    @chapters = @book.chapters
  end

  def search
    if Rails.env.production?
      @verses = Verse.includes(chapter: :book).where('text ~* ?', '\y%s\y' % params[:q])
    else
      @verses = Verse.includes(chapter: :book).where('text like ?', "%#{params[:q]}%")
    end
    @verses = @verses.old_testament if params[:old_testament].present? && !params[:new_testament]
    @verses = @verses.new_testament if params[:new_testament].present? && !params[:old_testament]
    @verses = @verses.order(id: :asc).page params[:page]
  end

end