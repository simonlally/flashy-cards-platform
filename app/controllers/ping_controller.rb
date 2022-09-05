class PingController < ApplicationController
  def index
    if current_user.present?
      render json: {
               status: "200",
               authenticated: true,
               user_email: current_user.email
             }
    else
      render json: { status: "200", authenticated: false, ping: "successful" }
    end
  end
end
