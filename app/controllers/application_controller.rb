class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t ".require_login"
    redirect_to login_path
  end
end
