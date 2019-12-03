class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin, only: [:edit, :update]

  def show; end

  def edit; end

  def update
    check = current_user.valid_password?(params[:old_password])
    if check && current_user.update(user_params)
      bypass_sign_in current_user
      flash[:success] = "Đổi mật khẩu thành công"
    else
      flash[:danger] = "Đổi mật khẩu thất bại"
    end
    redirect_to edit_user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_admin
    return if current_user.admin?

    flash[:danger] = "Bạn không được đổi mật khẩu"
    redirect_to current_user
  end
end
