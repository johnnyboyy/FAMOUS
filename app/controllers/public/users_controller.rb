class Public::UsersController < ApplicationController
  before_action :get_user

  def show
    if @user == current_user
      redirect_to user_path(current_user)
    end

    @songs = @user.public_songs.page params[:page]
    @bands = @user.bands
  end




  private

  def get_user
    @user = User.find(params[:id])
  end
end
