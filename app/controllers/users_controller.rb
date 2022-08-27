class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if params[:email].present? && params[:password].present?
      existing_user = User.find_by(email: params[:email])
      unless existing_user
        user = User.create(email: params[:email], password: params[:password])
        render json: {
                 status: "ok!",
                 email: user.email.to_json,
                 token: user.generate_jwt
               }
      end
    else
      render json:
               OpenStruct.new(
                 error: "bruh send real params, email and a username"
               )
    end
  end

  def new
    if params[:email].present? && params[:password].present?
      user = User.find_by(email: params[:email])
      unless user
        render json: {
                 status: "sadge",
                 error: "no user exists with this email"
               }
      end

      unless user.authenticate(params[:password])
        render json: {
                 status: "sadge",
                 error: "password is incorrect",
                 token: nil
               }
      end

      render json: { status: "ok!", token: user.generate_jwt }
    end
  end
end
