class ApplicationController < ActionController::Base
  include Auth
  skip_before_action :verify_authenticity_token

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

  def validate_current_user
    unless current_user.present?
      return(render json: { status: "failed", error: "not authenticated" })
    end
  end
end
