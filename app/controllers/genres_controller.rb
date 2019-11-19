class GenresController < ApplicationController
  def show
    @genre = Genre.find_by id: params[:id]
    @songs = @genre.songs.page(params[:page]).per Settings.pages.per_page
  end
end
