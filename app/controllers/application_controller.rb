class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def logged_in_user
    return if user_signed_in?

    store_location_for(:user, request.fullpath)
    flash[:danger] = t "users.require_login"
    redirect_to new_user_session_path
  end
end
