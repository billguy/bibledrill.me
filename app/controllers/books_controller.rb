class BooksController < KjController

  before_action :set_book, if: ->{ params[:book_id] }

  def index
    @old = Rails.cache.fetch('old'){ @bible.books.slice(0..38) }
    @new = Rails.cache.fetch('new'){ @bible.books.slice(39..65) }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show

  end

  private

    def set_book
      @book = Rails.cache.fetch("book/#{params[:book_id]}"){ @bible.book(params[:book_id]) }
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such book '#{params[:book_id]}'" }
    end

end