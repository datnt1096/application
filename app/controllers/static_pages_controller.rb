class StaticPagesController < ApplicationController
  def home
    @feed_items = Song.hot_feed
                      .page(params[:id]).per Settings.pages.feed
    @list_songs = Song.first(Settings.list_song)
    @list_song_slider = Song.last(Settings.list_song_slider)
    @top_songs = Song.order(view: :desc).take 5
  end
end
