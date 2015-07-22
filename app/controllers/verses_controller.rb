class VersesController < ChaptersController

  def index
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verses }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verses(params[:id]) }
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such verses(s) '#{params[:id]}' in '#{params[:book_id]}:#{params[:chapter_id]}'" }
  end

end