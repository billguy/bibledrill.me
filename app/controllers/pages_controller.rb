class PagesController < ApplicationController

  def show
    bible = Kj::Bible.new
    @verses = bible.page(params[:id])
    respond_to do |format|
      format.js
    end
  end

end
