class SongsController < ApplicationController
  before_action :correct_user, only: %i(update destroy)
  before_action :find_song, only: %i(show edit update destroy buy)
  before_action :support, only: :show
  before_action :authenticate_user!, only: %i(new create)

  def index
    @songs = Song.search_index(params[:search])
      .page(params[:page]).per Settings.pages.per_page
    @list_songs = Song.first Settings.list_song
  end

  def new
    @song = Song.new
    @song.build_singer
  end

  def create
    @song = Song.new song_params

    if @song.save
      flash[:success] = t ".success"
      redirect_to @song
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def show
    @comment = current_user.comments.build if user_signed_in?

    if @song.cost.present?
      if user_signed_in? && current_user.member?
        buy = current_user.buy_songs.find_by song_id: @song.id
        return render :unbuy if buy.blank?
      elsif user_signed_in? && current_user.admin?
      else
        render :unbuy
      end
    end
    increase_view
  end

  def edit
    return unless @song.singer
    @song.singer.name = nil
    @song.singer.description = nil
  end

  def update
    if @song.update song_params
      flash[:success] = t ".success"
      redirect_to @song
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @song.comments.destroy_all && @song.delete
      flash[:success] = t ".success"
    else
      flash[:danger] = t "failed"
    end
    redirect_to request.referrer || root_url
  end

  def buy
    if @song.cost.present?
      buy = current_user.buy_songs.find_by song_id: @song.id
      if buy.present?
        flash[:success] = "Bạn đã mua bài hát này trước đó."
      else
        data = {access_token: current_user.access_token, amount: @song.cost}
        response = JSON.parse request_api(data, "buy", :Get)
        if response["success"].present?
          current_user.buy_songs.create song: @song
          flash[:success] = response["success"]
        else
          flash[:danger] = response["error"]
        end
      end
    else
      flash[:success] = "Bài hát này miễn phí!"
    end
    redirect_to @song
  end

  private

  def song_params
    params.require(:song).permit Song::SONG_ATTRIBUTES
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_song
    @song = Song.include_to_song.find_by id: params[:id]
    redirect_to songs_url unless @song
  end

  def support
    @supports ||= Supports::SongSupport.new @song, current_user, params[:page]
  end

  def increase_view
    @song.increment! :view
    @song.save
  end

  def correct_user
    @song = Song.find_by id: params[:id]

    return if current_user.admin?
    flash[:danger] = t ".no_permit"
    redirect_to song_url
  end
end
