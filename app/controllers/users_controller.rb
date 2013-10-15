class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = current_user
		@songs = @user.songs
		@bands = @user.liked_bands
    @venues = @user.venues
    @page_options = 'users/pageOptions'

    @responses = []
    Request.where(sender: current_user.id).where(status: 'accepted').each do |req|
      unless @responses.map(&:band_id).include?(req.band_id)
        @responses << req
      end
    end

	end

  def has_venue
    current_user.set_venue_status
    redirect_to :root
  end


end