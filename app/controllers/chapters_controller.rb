class ChaptersController < BooksController

  before_action :set_chapter, if: ->{ params[:chapter_id] }

  def index
    @page_title = @book.title
    add_breadcrumb @book.name, book_chapters_path(book_id: @book.permalink), title: "#{@book.name} chapters", remote: true
    @chapters = Rails.cache.fetch("book/#{@book.name}/chapters"){ @book.chapters }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    set_chapter(params[:id])
    add_breadcrumb @book.name, book_chapters_path(book_id: @book.permalink), title: "#{@book.name} chapters", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Chapter #{@chapter.number} verses", remote: true
    @page_title = @chapter.title
    @verses = @chapter.verses
  end

  private

    def set_chapter(chapter_id=params[:chapter_id])
      @chapter = Rails.cache.fetch("book/#{@book.name}/chapter/#{chapter_id}"){ @book.chapter(chapter_id) }
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such chapter '#{chapter_id}' in book '#{params[:book_id]}}'" }
    end

end