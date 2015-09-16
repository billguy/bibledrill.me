class HighlightsController < ApplicationController

  def update
    @verse = Verse.find_by_id(params[:id])
    if current_user
      highlight = current_user.highlights.where(verse: @verse).first
      highlight.present? ? highlight.destroy : current_user.highlights.create(verse: @verse)
    end
  end

end