class VersesController < KjController

  def index
    @book = Book.find_by_permalink(params[:book_id])
    @chapter = @book.chapters.find_by_number(params[:chapter_id])
    @page_title = @chapter.title
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses"
    @verses = @chapter.verses
  end

  def show
    @book = Book.find_by_permalink(params[:book_id])
    @chapter = @book.chapters.find_by_number(params[:chapter_id])
    @verses = @chapter.verses.where(number: parsed_verses)
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number} verses", remote: true
    if @verses.length > 1
        @page_title = @chapter.title
    else
        @page_title = @verses.first.title
        add_breadcrumb "Verse #{@verses.first.number}", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verse #{@verses.first.number}", remote: true
    end
  end

  private

    def parsed_verses
      verses = params[:id].gsub(/\s+/, "")
      single_verses = verses.split(',').reject{|verse| verse =~ /\d{1,}\-\d{1,}/ }.map(&:to_i)
      ranges = verses.scan(/\d{1,}\-\d{1,}/).map{|range| Range.new(*range.split("-").map(&:to_i)).to_a }
      [single_verses, ranges].flatten.compact
    end

end