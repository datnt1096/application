class ApplicationController < ActionController::Base
  require "net/http"
  protect_from_forgery with: :exception

  private

  def logged_in_user
    return if user_signed_in?

    store_location_for(:user, request.fullpath)
    flash[:danger] = t "users.require_login"
    redirect_to new_user_session_path
  end

  def request_api data, path, request_type
    base_uri = ENV["RESOURCE_SERVER_URL"] || "http://localhost:3002/"
    uri = URI.parse(base_uri + path)
    http = Net::HTTP.new(uri.host, uri.port)

    if base_uri.start_with? "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = "Net::HTTP::#{request_type}".constantize.new(uri.path)
    request["Content-Type"] = "application/json"
    request.body = data.to_json
    response = http.request(request)
    response.body
  end

  def get_app_token
    data = {
      client_id: ENV["APP_ID"],
      client_secret: ENV["APP_SECRET"],
      grant_type: "client_credentials"
    }

    base_uri = ENV["OAUTH_SERVER_TOKEN_URL"] || "http://localhost:3001/oauth/token"
    uri = URI.parse(base_uri)
    http = Net::HTTP.new(uri.host, uri.port)

    if base_uri.start_with? "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"
    request.body = data.to_json
    response = http.request(request)
    response.body
  end
end
