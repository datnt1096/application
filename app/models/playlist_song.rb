class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  validates_uniqueness_of :playlist_id, scope: :song_id
end
