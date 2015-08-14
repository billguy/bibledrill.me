class SiteController < ApplicationController

  def index
  end

  def random_verse
    bible = Kj::Bible.new
    @verse = bible.random_verse
  end
end
