class ChaptersController < KjController

  before_action :set_book

  def index
    @page_title = @book.name
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true
    add_breadcrumb "Chapters", nil, title: "Chapters"
    @chapters = @book.chapters
  end

  def show
    @chapter = @book.chapters.find_by_number(params[:id])
    add_breadcrumb @book.name, :books_path, title: "Books", remote: true, data: { 'quick-menu' => true, menu: '#books-menu' }
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true, data: { 'quick-menu' => true, menu: '#book-chapters-menu' }
    add_breadcrumb "Verses", book_chapter_verses_path(book_id: @book.permalink, chapter_id: @chapter.number), title: "Verses", remote: true
    @page_title = @chapter.title
    @verses = @chapter.verses.reorder(id: :asc)
    @highlight_verse_ids = current_user ? current_user.highlights.where(verse_id: @verses.collect(&:id)).pluck(:verse_id) : []
    @prev_chapter = @chapter.prev
    @next_chapter = @chapter.next
  end

  private

    def set_book
      @book = Book.find_by_permalink(params[:book_id])
    end

end