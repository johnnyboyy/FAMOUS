class SongsController < ApplicationController

	def index
		@songs = Song.all
	end

	def new
		@band = Band.find(params[:band_id])
		@song = Song.new
		@song.band_id = @band.id
	end

	def create
		@band = Band.find(params[:band_id])
		@song = Song.new(song_params)
		@song.artist = @band.name

		if @song.save
			redirect_to band_songs_path
		else
			render 'new'
		end
	end

	def destroy
		@song = Song.find(params[:id])
		@song.destroy

		redirect_to band_songs_path, notice: "Succesfully removed song"
	end



	private

	def song_params
		params.require(:song).permit(:title, :artist, :band_id, :mp3_file)
	end
end
