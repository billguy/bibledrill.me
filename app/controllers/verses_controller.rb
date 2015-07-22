class VersesController < ChaptersController

  def index
    @page_title = @chapter.title
    add_breadcrumb "#{@book.name} chapters", book_chapters_path(book_id: @book.permalink), title: "#{@book.name} chapters"
    add_breadcrumb "Chapter #{@chapter.number} verses", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Chapter #{@chapter.number} verses"
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verses }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @verse = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verse(params[:id]) }
    @page_title = @verse.title
    add_breadcrumb "#{@book.name} chapters", book_chapters_path(book_id: @book.permalink), title: "#{@book.name} chapters"
    add_breadcrumb "Chapter #{@chapter.number} verses", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Chapter #{@chapter.number} verses"
    add_breadcrumb "Verse #{@verse.number}", nil, title: "Verse #{@verse.number}"
    respond_to do |format|
      format.html
      format.js
    end
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such verses(s) '#{params[:id]}' in '#{params[:book_id]}:#{params[:chapter_id]}'" }
  end

end