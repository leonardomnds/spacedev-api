class AuthController < ApplicationController
  skip_before_action :ensure_authentication, :switch_schema

  before_action :find_user_by_email, only: :sign_in

  def sign_in
    render json: { token: jwt_token }
  end

  def sign_out
    render json: { teste: true }
  end

  def me
    render json: { teste: true }
  end

  private

  def find_user_by_email
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])

    render_unauthorized unless @user
  end

  def jwt_token
    jwt_encode(jwt_payload)
  end

  def jwt_payload
    {
      user_id: @user.id,
      exp: 1.day.from_now.to_i
    }
  end

  def render_unauthorized
    raise Errors::Http::Unauthorized, 'Combinação de email e senha inválida'
  end
end
