module UsersHelper
  def gravatar_for user
    gravatar_url = user.image_url.present? ? "#{ENV['OAUTH_SERVER']}#{user.image_url}" : "avatar_icon.png"
    image_tag(gravatar_url, alt: user.name, class: "rounded-circle gravatar")
  end

  def check_buy song
    if song.cost.present?
      if user_signed_in?
        buy = current_user.buy_songs.find_by song_id: song.id
        buy.present? ? "Đã mua" : number_to_currency(song.cost, precision: 0, unit: "đ")
      else
        number_to_currency(song.cost, precision: 0, unit: "đ")
      end
    else
      "Miễn phí"
    end
  end
end
