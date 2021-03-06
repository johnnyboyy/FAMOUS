class SongsController < ApplicationController
	before_action :get_song, only: [:destroy]
	before_action :get_band, only: [:new, :create]


	def index
		@songs = Song.all.order("fame DESC").page params[:page]
	end

	def new
		@song = Song.new
	end

	def create
		@song = Song.new(song_params)
		set_extra_fields

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
			params.require(:song).permit(:title, :artist, :band_id, :mp3_file, :genres_list)
		end

		def song_field(current_song)
			current_song.band.profile_pic.url
		end

		def get_song
			@song = Song.find(params[:id])
		end

		def get_band
			@band = Band.find(params[:band_id])
		end

		def set_extra_fields
			@song.band_id = @band.id
			@song.artist = @band.name
			@song.genres_list = params[:song][:genres_list]
		end
end
