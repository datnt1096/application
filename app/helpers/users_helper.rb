module UsersHelper
  def gravatar_for user
    gravatar_url = user.image_url.present? ? user.image_url : "avatar_icon.png"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def check_buy song
    # if current_user
    #   song.cost ? number_to_currency(song.cost, locale: :vn) : "Miễn phí"
    # else
    #   "Đã mua"
    # end
    song.cost ? number_to_currency(song.cost, precision: 0, unit: "đ") : "Miễn phí"
  end
end
