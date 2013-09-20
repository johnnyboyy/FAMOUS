class SongsController < ApplicationController

	def index
		@songs = Song.all
		@artist = Band.find(@song.band_id).name
	end

	def new
		@song = Song.new
		@song.band_id = params[:band_id]
	end

	def create
		@band = Band.find(params[:band_id])
		@song = Song.create(params[:song].permit(:name, :band_id))
		@song.artist = @band.name

		if @band.songs.save
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
		params.require(:song).permit(:title, :mp3_file)
	end
end
