class Users::BuyedsController < ApplicationController
  before_action :logged_in_user

  def index
    @songs = current_user.song_buyeds.page(params[:page]).per Settings.per_page
  end
end
