class StudiesController < ApplicationController

  load_and_authorize_resource find_by: :permalink
  skip_authorize_resource only: [:index, :show, :books, :chapters, :verses, :search]

  # GET /studies
  # GET /studies.json
  def index
    @type = params[:type].try(:downcase)
    case @type
      when "popular"
        @studies = Study.popular.page(params[:page])
      when "liked"
        @studies = current_user ? current_user.get_voted(Study).page(params[:page]) : Kaminari.paginate_array([]).page(params[:page])
      when "mine"
        @studies = current_user ? Study.mine(current_user.id).page(params[:page]) : Kaminari.paginate_array([]).page(params[:page])
      else
        @studies = Study.recent.page(params[:page])
    end
  end

  def books
    @old = Book.old_testament
    @new = Book.new_testament
  end

  def chapters
    @book = Book.find_by_permalink(params[:book_id])
    add_breadcrumb @book.name, :books_studies_path, title: "Books", remote: true
    add_breadcrumb "Chapters", chapters_studies_path(book_id: @book.permalink), title: "Chapters", remote: true
    @chapters = @book.chapters
  end

  def verses
    @book = Book.find_by_permalink(params[:book_id])
    @chapter = @book.chapters.find_by_number(params[:chapter_number])
    add_breadcrumb @book.name, :books_studies_path, title: "Books", remote: true
    add_breadcrumb "Chapter #{@chapter.number}", chapters_studies_path(book_id: @book.permalink), title: "Chapter #{@chapter.number}", remote: true
    @verses = @chapter.verses.reorder(id: :asc)
    @prev_chapter = @chapter.prev
    @next_chapter = @chapter.next
  end

  def search
    if Rails.env.production?
      @studies = Study.search_by_keyword(params[:q]).page(params[:page])
    else
      @studies = Study.where('title like :keyword or description like :keyword', keyword: "%#{params[:q]}%").page(params[:page])
    end
  end

  def like
    current_user.voted_up_on?(@study) ? @study.unliked_by(current_user) : @study.liked_by(current_user)
    respond_to do |format|
      format.js
    end
  end

  # def dislike
  #   current_user.voted_down_on?(@card) ? @card.undisliked_by(current_user) : @card.disliked_by(current_user)
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  # GET /studies/1
  # GET /studies/1.json
  def show
    impressionist(@study, unique: [:session_hash]) #track page view count
  end

  # GET /studies/new
  def new
    @study = Study.new
    @study.sections.build
  end

  # GET /studies/1/edit
  def edit
  end

  # POST /studies
  # POST /studies.json
  def create
    @study.user = current_user

    respond_to do |format|
      if @study.save
        format.html { redirect_to @study, notice: 'Study was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /studies/1
  # PATCH/PUT /studies/1.json
  def update
    respond_to do |format|
      if @study.update(study_params)
        format.html { redirect_to @study, notice: 'Study was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroy
    @study.destroy
    respond_to do |format|
      format.html { redirect_to studies_url, notice: 'Study was successfully destroyed.' }
    end
  end

  private

    def study_params
      params.require(:study).permit(
        [
          :title, :description,
          sections_attributes: [
            :id, :study_id, :_destroy, :title, :notes, :position,
            section_verses_attributes: [:id, :_destroy, :position, :verse_id]
          ]
        ]
      )
    end
end