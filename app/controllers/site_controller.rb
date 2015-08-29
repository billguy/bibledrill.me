class SiteController < ApplicationController

  def index
  end

  def random_verse
    @verse = Verse.random
  end
end
