class KjController < ApplicationController

  before_action :set_bible

  def index
    @verse = @bible.random_verse
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def set_bible
      @bible = Kj::Bible.new
    end

end
