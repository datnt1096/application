class User < ApplicationRecord
  attr_accessor :skip_password_validation

  devise :database_authenticatable, :rememberable, :validatable, :omniauthable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  enum role: {admin: 1, member: 0}

  has_many :comments
  has_many :likeds, dependent: :destroy
  has_many :liked_songs, through: :likeds, source: :song
  has_many :buy_songs, dependent: :destroy
  has_many :song_buyeds, through: :buy_songs, source: :song
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

  def self.from_omniauth auth
    user = find_by email: auth[:info][:email]
    params = {}
    params[:name] = auth[:info][:name]
    params[:image_url] = auth[:info][:image_url]
    params[:access_token] = auth[:credentials][:token]
    if user.present?
      user.update params
    else
      params[:email] = auth[:info][:email]
      user = new params
      user.skip_password_validation = true
      user.save
    end
    user
  end

  protected

  def downcase_email
    email.downcase!
  end

  def password_required?
    return false if skip_password_validation
    super
  end
end

