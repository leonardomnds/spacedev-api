class AuthController < ApplicationController
  skip_before_action :ensure_authentication, :switch_schema, only: :sign_in

  before_action :authenticate, :session_token, only: :sign_in

  def sign_in
    @token = jwt_token

    @user.update!(session_token: @session_token)

    response.set_cookie('Authorization', cookie_payload)

    render json: { token: @token }
  end

  def sign_out
    close_session

    render json: { message: 'Sessão encerrada com sucesso' }
  end

  def me
    render json: @current_user, serializer: Api::V1::Users::ShowSerializer
  end

  def update_password
    raise Errors::Http::BadRequest, 'Obrigátório informar a senha' if params[:password].blank?

    @current_user.update!(password: params[:password])

    close_session

    render json: { message: 'Sessão encerrada. Faça login novamente para continuar.' }
  end

  private

  def authenticate
    params[:is_client].present? ? authenticate_client : authenticate_user

    render_unauthorized unless @user
  end

  def authenticate_user
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])
  end

  def authenticate_client
    @user = Client.by_cpf_cnpj(params[:cpf_cnpj]).first&.authenticate(params[:password])
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
      is_client: params[:is_client].present?,
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

  def close_session
    response.delete_cookie('Authorization')

    @current_user.update!(session_token: nil)
  end

  def render_unauthorized
    raise Errors::Http::Unauthorized, 'Combinação de email e senha inválida'
  end
end
