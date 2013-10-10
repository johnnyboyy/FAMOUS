class MainController < ApplicationController

	def index
		@songs = Song.all.order("fame DESC")
		@bands = Band.all.order("fame DESC")
    @topsong = Song.joins(:likes).where("likes.created_at > ?", 1.day.ago).order("songs.fame DESC").first  || Song.order("fame DESC").first
    @topsongoftheweek = Song.joins(:likes).where("likes.created_at > ?", 7.day.ago).order("songs.fame DESC").first  || Song.order("fame DESC").first

    @five_or_under = Genre.count
    @genres = Genre.all
    @page_options = 'main/mainOptions'
  end

end