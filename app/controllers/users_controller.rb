class UsersController < ApplicationController
  def create
    if params[:email].present? && params[:password].present?
      unless URI::MailTo::EMAIL_REGEXP.match(params[:email].strip)
        return(
          render json: {
                   status: 400,
                   error: "email address provided is invalid"
                 }
        )
      end

      existing_user = User.find_by(email: params[:email])

      if existing_user
        return(
          render json: {
                   status: 400,
                   error: "a user already exists with that email"
                 }
        )
      end

      unless params[:password].length.between?(8, 22)
        return(
          render json: {
                   status: 400,
                   error: "password must be between 8 and 22 characters long"
                 }
        )
      end

      user = User.create(email: params[:email], password: params[:password])

      if user
        render json: {
                 status: 200,
                 email: user.email,
                 token: user.generate_jwt
               }
      end
    else
      return(
        render json: {
                 error: "bruh send real params, email and a username",
                 status: 400
               }
      )
    end
  end

  def new
    if params[:email].present? && params[:password].present?
      user = User.find_by(email: params[:email])
      unless user
        render json: { status: 404, error: "no user exists with this email" }
      end

      unless user.authenticate(params[:password])
        render json: { status: 401, error: "password is incorrect", token: nil }
      end

      render json: { status: 200, token: user.generate_jwt }
    end
  end
end
