class ApplicationController < ActionController::Base
  include Auth

  def authenticate_user
    if auth_present?
      bearer_token = request.headers["authorization"]&.split("Bearer")[1].strip
      token = decode(bearer_token)
      User.find(token["id"]) if token
    end
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    nil
  end

  def current_user
    @current_user ||= authenticate_user
  end
end
