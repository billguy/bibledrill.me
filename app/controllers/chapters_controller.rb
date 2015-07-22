class ChaptersController < BooksController

  before_action :set_chapter, if: ->{ params[:chapter_id] }

  def index
    @page_title = @book.title
    add_breadcrumb "#{@book.name} chapters", book_chapters_path(book_id: @book.permalink), title: "#{@book.name} chapters"
    @chapters = Rails.cache.fetch("book/#{@book.name}/chapters"){ @book.chapters }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show

  end

  private

    def set_chapter
      @chapter = Rails.cache.fetch("book/#{@book.name}/chapter/#{params[:chapter_id]}"){ @book.chapter(params[:chapter_id]) }
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such chapter '#{params[:chapter_id]}' in book '#{params[:book_id]}}'" }
    end

end