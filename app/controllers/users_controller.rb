class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = current_user
		@songs = @user.songs
		@bands = @user.bands
	end
end