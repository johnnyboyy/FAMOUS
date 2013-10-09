class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = current_user
		@songs = @user.songs
		@bands = @user.liked_bands
    @venues = @user.venues
    @page_options = 'users/pageOptions'
	end


end