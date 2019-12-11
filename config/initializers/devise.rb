Devise.setup do |config|
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 7.days
  config.sign_out_via = :delete
  config.omniauth :framgia, ENV["APP_ID"], ENV["APP_SECRET"],
    client_options: {
        site: ENV["RESOURCE_SERVER_URL"],
        authorize_url: ENV["OAUTH_SERVER_AUTHORIZATION_URL"],
        token_url: ENV["OAUTH_SERVER_TOKEN_URL"]
    }
end
