class BaseController < ActionController::API
  API_AUTH_TOKEN = Rails.application.secrets[:api_auth_token].freeze

  before_action :authenticate

  def authenticate
    return true if API_AUTH_TOKEN.blank? # && (Rails.env.development? || Rails.env.test?)
    authenticate_with_http_token do |token, _options|
      # Compare the tokens in a time-constant manner, to mitigate timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(API_AUTH_TOKEN)
      )
    end
  end
end
