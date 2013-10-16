class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search
    song = Song.where('title ILIKE ?', "%#{params[:term]}")
  end 

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      user_path(current_user)
    else
      root_path
    end
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





end
