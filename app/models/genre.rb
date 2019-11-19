class Genre < ApplicationRecord
  has_many :genre_songs
  has_many :songs, through: :genre_songs

  validates :title, presence: true,
    length: {maximum: Settings.title.max_length}
end
