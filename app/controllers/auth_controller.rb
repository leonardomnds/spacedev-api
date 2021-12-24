class AuthController < ApplicationController
  skip_before_action :ensure_authentication, :switch_schema, only: :sign_in

  before_action :find_user_by_email, :session_token, only: :sign_in

  def sign_in
    @token = jwt_token

    @user.update!(session_token: @session_token)

    response.set_cookie('Authorization', cookie_payload)

    render json: { token: @token }
  end

  def sign_out
    response.delete_cookie('Authorization')

    @current_user.update!(session_token: nil)

    render json: { message: 'Sessão encerrada com sucesso' }
  end

  def me
    render json: @current_user, serializer: Api::V1::Users::ShowSerializer
  end

  private

  def find_user_by_email
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])

    render_unauthorized unless @user
  end

  def session_token
    @session_token ||= SecureRandom.hex(16)
  end

  def jwt_token
    jwt_encode(jwt_payload)
  end

  def jwt_payload
    {
      user_id: @user.id,
      session_token: @session_token,
      exp: 1.day.from_now.to_i
    }
  end

  def cookie_payload
    {
      value: @token,
      expires: 1.day.from_now,
      path: '/'
    }
  end

  def render_unauthorized
    raise Errors::Http::Unauthorized, 'Combinação de email e senha inválida'
  end
end
