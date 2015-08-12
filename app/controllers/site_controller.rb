class SiteController < ApplicationController

  def index
    @page_count = Kj::Bible.page_count
  end
end
