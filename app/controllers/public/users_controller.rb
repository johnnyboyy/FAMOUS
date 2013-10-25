class Public::UsersController < ApplicationController

  def show
    if User.find(params[:id]) == current_user
      redirect_to user_path(current_user)
    end
  end
end
