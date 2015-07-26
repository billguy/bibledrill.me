class ChaptersController < BooksController

  before_action :set_chapter, if: ->{ params[:chapter_id] }

  def index
    @page_title = @book.title
    add_breadcrumb "Chapters", nil, title: "Chapters"
    @chapters = Rails.cache.fetch("book/#{@book.name}/chapters"){ @book.chapters }
  end

  def show
    set_chapter(params[:id])
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses", nil, title: "Verses"
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