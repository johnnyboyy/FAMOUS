class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search
    song = Song.where('title ILIKE ?', "%#{params[:term]}")
  end 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {
    				 |u| u.permit(:first_name, :last_name,
												 :email, :password, 
												 :password_confirmation, :profile_pic,
                         :provider, :uid) 
    				}

    devise_parameter_sanitizer.for(:account_update) {
             |u| u.permit(:current_password, :password, 
                         :password_confirmation, :profile_pic) 
            }

  end

  def song_field(current_song)
    # gets overriden by bands and songs controllers
  end


end
