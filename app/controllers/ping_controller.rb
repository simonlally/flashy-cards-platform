class PingController < ApplicationController
  def index
    if current_user.present?
      render json: { status: "ok!", user_email: current_user.email }
    else
      render json: { status: "unauthenticated", ping: "successful" }
    end
  end
end
