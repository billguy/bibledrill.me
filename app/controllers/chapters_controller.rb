class ChaptersController < KjController

  def index
    # @book = Book.includes(:chapters).where(permalink: params[:book_id]).first
    @chapter = Chapter.includes(:book).where(books: { permalink: params[:book_id] } ).first
    @page_title = @chapter.book_name
    add_breadcrumb @chapter.book_name, :books_path, title: "Books", remote: true, class: 'tab-link books'
    add_breadcrumb "Chapters", nil, title: "Chapters"
  end

  def show
    @chapter = Chapter.includes(:book, :verses).where(books: { permalink: params[:book_id] }, chapters: { number: params[:id] } ).first
    add_breadcrumb @chapter.book_name, :books_path, title: "Books", remote: true, data: { 'quick-menu' => true, menu: '#books-menu' }, class: 'tab-link books'
    add_breadcrumb "Chapter #{@chapter.number}", book_chapters_path(book_id: @chapter.book_permalink), title: "Chapter #{@chapter.number}", remote: true, data: { 'quick-menu' => true, menu: '#book-chapters-menu' }, class: 'tab-link'
    add_breadcrumb "Verses", book_chapter_verses_path(book_id: @chapter.book_permalink, chapter_id: @chapter.number), title: "Verses", remote: true, class: 'tab-link'
    @page_title = @chapter.title
    @highlight_verse_ids = current_user ? current_user.highlights.where(verse_id: @chapter.verses.collect(&:id)).pluck(:verse_id) : []
  end

end