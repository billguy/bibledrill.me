class PagesController < ApplicationController

  def show
    @verses = Verse.where(page: params[:id])
    @previous_verse = @verses.first.try(:prev)
    @previous_book_name = @previous_verse.try(:book_name)
    @previous_chapter_id = @previous_verse.try(:chapter_id)
    respond_to do |format|
      format.js
    end
  end

end