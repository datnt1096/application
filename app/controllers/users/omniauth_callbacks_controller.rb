class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    remember_me @user
    flash[:success] = "Đăng nhập qua Oauth Server thành công"
    redirect_to root_path
  end

  def failure
    flash[:danger] = "Đăng nhập qua Oauth Server thất bại!"
    redirect_to new_user_session_path
  end

  alias_method :framgia, :create
end
