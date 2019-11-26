class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates :content, presence: true,
    length: {maximum: Settings.content.max_length}
  validates :user_id, presence: true
  validates :song_id, presence: true

  scope :ordered, ->{order created_at: :desc}
end
