class BooksController < KjController

  before_action :set_book, if: ->{ params[:book_id] }
  before_action :set_breadcrumb, if: ->{ params[:book_id] }

  def index
    @page_title = "Books"
    @old = Rails.cache.fetch('old'){ @bible.books.slice(0..38) }
    @new = Rails.cache.fetch('new'){ @bible.books.slice(39..65) }
  end

  def show
    @book = Rails.cache.fetch("book/#{params[:id]}.json"){ @bible.book(params[:id]) }
    @chapters = @book.chapters
  end

  private

    def set_breadcrumb
      add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    end

    def set_book
      @book = Rails.cache.fetch("book/#{params[:book_id]}"){ @bible.book(params[:book_id]) }
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such book '#{params[:book_id]}'" }
    end

end