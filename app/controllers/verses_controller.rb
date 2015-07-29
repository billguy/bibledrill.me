class VersesController < ChaptersController

  def index
    @page_title = @chapter.title
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses"
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{params[:id]}"){ @chapter.verses }
  end

  def show
    @verses = Rails.cache.fetch("book/#{@book.name}/chapter/#{@chapter.number}/verses/#{parsed_verses.join}"){ @chapter.verses(parsed_verses) }
    add_breadcrumb "Chapter #{@chapter.number}", book_chapter_path(book_id: @book.permalink, id: @chapter.number), title: "Chapter #{@chapter.number} verses", remote: true
    if @verses.length > 1
        @page_title = @chapter.title
    else
        @page_title = @verses.first.title
        add_breadcrumb "Verse #{@verses.first.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verse #{@verses.first.number}", remote: true
    end
    rescue Kj::Iniquity
      redirect_to root_path, flash: { error: "No such verses(s) '#{params[:id]}' in '#{params[:book_id]}:#{params[:chapter_id]}'" }
  end

  private

    def parsed_verses
      @parsed_verses ||= begin
        verses = params[:id].gsub(/\s+/, "")
        single_verses = verses.split(',').reject{|verse| verse =~ /\d{1,}\-\d{1,}/ }.map(&:to_i)
        ranges = verses.scan(/\d{1,}\-\d{1,}/).map{|range| Range.new(*range.split("-").map(&:to_i)).to_a }
        [single_verses, ranges].flatten.compact
      end
    end

end