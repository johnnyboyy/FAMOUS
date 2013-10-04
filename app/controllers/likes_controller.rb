class LikesController < ApplicationController
	before_action :get_song, only: [:like, :unlike]

	def like

		respond_to do |format|

			if @song.likes.create(user_id: current_user.id)
				@song.fame = @song.updated_fame
				@song.save

				format.html { redirect_to :back }
				format.js { render "songs/likeToggle" }
			else
				format.html { redirect_to :back, alert: "You can't like a song more than once!" }
				format.js { render :back, alert: "You can't like a song more than once!"  }
			end
		end
	end

	def unlike
		@like = @song.likes.where(user_id: current_user.id).first.destroy
	
		respond_to do |format|
			if @song.likes.map(&:user).include?(@like.user)

				flash.now[:alert] = "You already unliked this song!"
				format.html { redirect_to :back  }
				format.js { render "songs/likeToggle" }

			else

				@song.fame = @song.updated_fame
				@song.save

				format.html { redirect_to :back }
				format.js { render "songs/likeToggle" }
			end
		end
	end


	private

	def get_song
		@song = Song.find(params[:id])
	end

end
