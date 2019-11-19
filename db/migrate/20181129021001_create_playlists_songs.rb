class CreatePlaylistsSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists_songs do |t|
      t.references :playlist, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
