class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  enum role: {admin: 1, member: 0}

  has_many :comments
  has_many :likeds, dependent: :destroy
  has_many :liked_songs, through: :likeds, source: :song
  validates :name, presence: true,
    length: {maximum: Settings.user.name.length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: Settings.user.case_sensitive}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length},
    allow_nil: true

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
