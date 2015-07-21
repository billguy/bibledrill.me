class KjController < ApplicationController

  require 'kj'

  def index
    bible = Kj::Bible.new
    @verse = bible.random_verse
    respond_to do |format|
      format.html
      format.js
    end
  end

end
