class Users::LikedsController < ApplicationController
  before_action :logged_in_user

  def index
    @songs = current_user.liked_songs.page(params[:page]).per Settings.per_page
  end
end
