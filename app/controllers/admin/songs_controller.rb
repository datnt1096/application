class Admin::SongsController < ApplicationController
  before_action :current_song, only: %i(edit update destroy)

  def new
    @song = Song.new
  end

  def create
    @song = Song.new song_params

    if @song.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def edit; end

  def update
    if @song.update song_params
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @song.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t "failed"
    end
    redirect_to root_url
  end

  private

  def song_params
    params.require(:song).permit Song::SONG_ATTRIBUTES
  end

  def current_song
    @song = Song.find_by id: params[:id]
  end
end
