class SongsController < ApplicationController
	before_action :get_song, only: [:like, :unlike, :destroy]

	# custom actions


	# end custom actions


	def index
		@songs = Song.all.order("fame DESC")
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
			redirect_to band_path(@band), notice: "#{@song.title} was added"
		else
			render 'new'
		end
	end

	def destroy
		@song.destroy
		@band = Band.find(@song.band_id)

		redirect_to @band, notice: "Succesfully removed song"
	end



	private

	def song_params
		params.require(:song).permit(:title, :artist, :band_id, :mp3_file)
	end

	def song_field(current_song)
		current_song.band.profile_pic.url
	end

	def get_song
		@song = Song.find(params[:id])
	end
end
