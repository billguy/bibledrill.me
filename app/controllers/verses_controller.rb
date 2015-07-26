class VersesController < ChaptersController

  def index
    @page_title = @chapter.title
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses"
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verses }
  end

  def show
    @verse = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verse(params[:id]) }
    @page_title = @verse.title
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Chapter #{@chapter.number} verses", remote: true
    add_breadcrumb "Verse #{@verse.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verse #{@verse.number}", remote: true
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such verses(s) '#{params[:id]}' in '#{params[:book_id]}:#{params[:chapter_id]}'" }
  end

end