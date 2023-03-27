class BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  API_AUTH_TOKEN = Rails.application.secrets[:api_auth_token].freeze

  before_action :authenticate
  before_action :check_auth

  class NotAuthorized < StandardError; end

  rescue_from NotAuthorized, with: :user_not_authorized

  private

  def user_not_authorized
    render(json: {}.to_json, status: 401)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      # Compare the tokens in a time-constant manner, to mitigate timing attacks.
      @authenticated = ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(API_AUTH_TOKEN)
      )
    end
  end

  def check_auth
    raise NotAuthorized unless @authenticated
  end
end
