class MainController < ApplicationController

	def index
		@songs = Song.all.order("fame DESC")
		@bands = Band.all
	end
end
