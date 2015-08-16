class KjController < ApplicationController

  # before_action :set_expires_in

  def index
    @page_title = "KJ"
    @verse = $bible.random_verse
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    # def set_expires_in
    #   expires_in 3.hours, public: true
    # end

end
