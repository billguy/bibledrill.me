class BooksController < KjController

  def index
    @page_title = "King James Bible"
  end

  def show
    @book = Book.includes(:chapters).where(permalink: params[:id]).first
    @page_title = @book.name
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true, class: 'tab-link'
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
    @page_title = "Search: #{params[:q]}"
    respond_to do |format|
      format.js
      format.html { render 'search', layout: false }
    end
  end

end