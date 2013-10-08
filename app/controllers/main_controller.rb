class MainController < ApplicationController

	def index
		@songs = Song.all.order("fame DESC")
		@bands = Band.all
    @topsong = Song.joins(:likes).where("likes.created_at > ?", 1.day.ago).order("songs.fame DESC").first
    @topsongoftheweek = Song.joins(:likes).where("likes.created_at > ?", 7.day.ago).order("songs.fame DESC").first
  end
end