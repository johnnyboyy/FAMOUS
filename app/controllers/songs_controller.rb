class SongsController < ApplicationController

	# custom actions

	def like
		@song = Song.find(params[:id])
		@song.likes.create(liked: true, user_id: current_user.id)

		redirect_to @song.band
	end

	def unlike
		@song = Song.find(params[:id])
		@like = @song.likes.where(user_id: current_user.id).first
		@like.destroy

		redirect_to @song.band
	end

	# end custom actions


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
			redirect_to band_path(@band), notice: "#{@song.title} was added"
		else
			render 'new'
		end
	end

	def destroy
		@song = Song.find(params[:id])
		@song.destroy
		@band = Band.find(@song.band_id)

		redirect_to @band, notice: "Succesfully removed song"
	end



	private

	def song_params
		params.require(:song).permit(:title, :artist, :band_id, :mp3_file)
	end
end
