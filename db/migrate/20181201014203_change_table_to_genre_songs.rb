class ChangeTableToGenreSongs < ActiveRecord::Migration[5.2]
  def change
    rename_table :geners_songs, :genre_songs
  end
end
