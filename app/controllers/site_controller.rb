class SiteController < ApplicationController

  def index
    @page_count = Kj::Bible.page_count
  end

  def random_verse
    bible = Kj::Bible.new
    @verse = bible.random_verse
  end
end
