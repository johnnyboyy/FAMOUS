class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@songs = current_user.songs
		@bands = current_user.liked_bands
    @venues = current_user.venues
    @requests = current_user.sent_requests

    @page_options = 'users/pageOptions'
	end

  def has_venue
    current_user.set_venue_status
    redirect_to :root
  end


end