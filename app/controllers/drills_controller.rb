class DrillsController < ApplicationController

  def index
    @page_title = "Online Bible Drill"
    @page_description = "Hone your verse finding skill with our innovative , online Bible drill.  Click on the right side of the cover to start the drill."
  end

  def new
    @verse = Verse.random
  end

  def create
    @time = params[:time].to_i/1000
    @hint = params[:hint] == "false" ? false : true
    @verse = Verse.includes(chapter: :book).find(params[:verse_id])
    drill_lb = Leaderboard.new(@verse.id, Leaderboard::DEFAULT_OPTIONS, { redis_connection: $redis})
    if current_user && !@hint
      drill_lb.rank_member(current_user.id, @time, {username: current_user.username, datetime: DateTime.now.to_i}.to_json)
    end
    @leaders = drill_lb.leaders(3, with_member_data: true)
  end
end