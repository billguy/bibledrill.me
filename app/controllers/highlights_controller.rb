class HighlightsController < ApplicationController

  def update
    @verse = Verse.find_by_id(params[:id])
    if current_user
      current_user.highlights.include?(@verse) ? current_user.higlights.where(verse: @verse).destroy : current_user.higlights.create(verse: @verse)
    end
  end

end