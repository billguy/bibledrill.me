class DrillsController < ApplicationController

  def index
  end

  def new
    @verse = Verse.random
  end

  def create
    @time = params[:time].to_i/1000
    @verse = Verse.includes(chapter: :book).find(params[:verse_id])
    drill_lb = Leaderboard.new(@verse.id, Leaderboard::DEFAULT_OPTIONS, { redis_connection: $redis})
    if current_user
      drill_lb.rank_member(current_user.id, @time, {username: current_user.username, datetime: DateTime.now.to_i}.to_json)
    end
    @leaders = drill_lb.leaders(3, with_member_data: true)
  end
end