class UsersController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create_token]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def create_token
    unless params[:email].present?
      return render json: { error: I18n.t('create_token.email_not_present') },
                    status: :unauthorized
    end

    unless params[:password].present?
      return render json: { error: I18n.t('create_token.password_not_present') },
                    status: :unauthorized
    end

    user = User.find_by(email: params[:email])

    unless user.present? && user.authenticate(params[:password])
      return render json: { error: I18n.t('create_token.email_or_password_not_match') },
                    status: :unauthorized
    end

    render json: { token: generate_token(user) },
           status: :ok
  end

  private

  def generate_token(user)
    JWT.encode({ user_id: user.id, exp: 30.seconds.from_now.to_i }, Rails.application.secret_key_base)
  end
end
