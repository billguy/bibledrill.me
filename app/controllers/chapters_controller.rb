class ChaptersController < KjController

  def index
    @book = Book.find_by_permalink(params[:book_id])
    @page_title = @book.name
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapters", nil, title: "Chapters"
    @chapters = @book.chapters.to_a
  end

  def show
    @book = Book.find_by_permalink(params[:book_id])
    @chapter = @book.chapters.find_by_number(params[:id])
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    add_breadcrumb "Verses", nil, title: "Verses"
    @page_title = @chapter.title
    @verses = @chapter.verses
  end

end