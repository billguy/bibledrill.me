class HighlightsController < ApplicationController

  def index
    @highlights = current_user ? current_user.highlights.order(verse_id: :asc).page(params[:page]) : []
    respond_to do |format|
      format.js
    end
  end

  def update
    @verse = Verse.find_by_id(params[:id])
    if current_user
      highlight = current_user.highlights.where(verse: @verse).first
      highlight.present? ? highlight.destroy : current_user.highlights.create(verse: @verse)
    end
  end

end