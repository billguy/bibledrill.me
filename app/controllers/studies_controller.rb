class StudiesController < ApplicationController

  load_and_authorize_resource find_by: :permalink
  skip_authorize_resource only: [:index, :show]

  # GET /studies
  # GET /studies.json
  def index
    @studies = Study.active
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
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
          section_attributes: [
            :id, :study_id, :_destroy, :title, :notes, :parent_id, :lft, :rgt,
            verse_attributes: [:id, :_destroy]
          ]
        ]
      )
    end
end