class MainController < ApplicationController

	def index
		@songs = Song.all
		@bands = Band.all
	end
end
