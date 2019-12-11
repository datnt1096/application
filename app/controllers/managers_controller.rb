class ManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def token
    response = JSON.parse get_app_token
    if response["token"].present?
      file = File.open("app_access_token.txt", "a+")
      file.truncate(0)
      file.write response["token"]
      file.close

      flash[:success] = "Lấy access token app thành công"
    else
      flash[:danger] = "Lấy access token app thất bại"
    end
    redirect_to managers_edit_path
  end

  def edit
    file = File.open("app_access_token.txt", "a+")
    file_data = file.read
    file.close

    if file_data.present?
      response = JSON.parse request_api({access_token: file_data}, "apps", :Get)
      if response["id"].present?
        @app = response
      else
        flash[:danger] = "Lấy thông tin lỗi, thử lấy lại access_token"
        render :unknow_token
      end
    else
      flash[:danger] = "Chưa có access token, hãy lấy access token để tiếp tục"
      render :unknow_token
    end
  end

  def update
    file = File.open("app_access_token.txt", "a+")
    file_data = file.read
    file.close

    if file_data.present?
      data = {
        name: params[:name],
        home_page: params[:home_page],
        description: params[:description],
        callback_url: params[:callback_url],
        access_token: file_data
      }
      response = JSON.parse request_api(data, "apps", :Post)
      if response["success"].present?
        flash[:success] = "Cập nhật thông tin ứng dụng thành công"
      else
        flash[:danger] = "Lấy thông tin lỗi, thử lấy lại access_token"
      end
    else
      flash[:danger] = "Chưa có access token, hãy lấy access token để tiếp tục"
    end
    redirect_to managers_edit_path
  end

  private

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
