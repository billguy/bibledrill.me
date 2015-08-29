class PagesController < ApplicationController

  def show
    @verses = Rails.cache.fetch("pages/#{params[:id]}"){ Verse.where(page: params[:id]) }
    @previous_verse = Rails.cache.fetch("books/#{params[:id]}/prev_verse") { @verses.first.try(:prev) }
    @previous_book_name = Rails.cache.fetch("books/#{params[:id]}/prev_book_name") { @previous_verse.try(:book_name)}
    @previous_chapter_id = Rails.cache.fetch("books/#{params[:id]}/prev_chapter_id") { @previous_verse.try(:chapter_id) }
    respond_to do |format|
      format.js
    end
  end

end