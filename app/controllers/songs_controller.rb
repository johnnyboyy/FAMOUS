class SongsController < ApplicationController

	# custom actions

	def like
		@song = Song.find(params[:id])

		respond_to do |format|

			if @song.likes.create(user_id: current_user.id)

				format.html { redirect_to :back }
				format.js { render "songs/likeToggle" }

				@song.fame += 1
				@song.save
			else
				format.html { redirect_to :back, alert: "You can't like a song more than once!" }
				format.js { render :back, alert: "You can't like a song more than once!"  }
			end
		end
	end

	def unlike
		@song = Song.find(params[:id])
		@like = @song.likes.where(user_id: current_user.id).first
		respond_to do |format|
			if @like
				format.html { redirect_to :back }
				format.js { render "songs/likeToggle" }

				@like.destroy
				@song.fame -= 1
				@song.save
			else
				format.html { redirect_to :back, alert: "You already unliked this song!"  }
				format.js { redirect_to :back, alert: "You already unliked this song!"  }
			end
		end
	end

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
		@song = Song.find(params[:id])
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
end
