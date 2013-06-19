class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :resource, :resource_name, :devise_mapping

  # Method for devise usage
  def resource_name
    :user
  end
 
  # Method for devise usage
  def resource
    @resource ||= User.new
  end
 
  # Method for devise usage
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Forces the user to sign in
  def authenticate_user!
    if !current_user
      flash[:alert] = "You must be signed in to do that!"
      redirect_to new_user_session_path
    end
  end
end
