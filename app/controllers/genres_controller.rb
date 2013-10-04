class GenresController < ApplicationController

	def index
		@genres = Genre.all
	end

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.build(genre_params)
	end




	private

	def genre_params
		params.require(:genre).permit(:name)
	end
end
