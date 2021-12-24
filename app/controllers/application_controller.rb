class ApplicationController < ActionController::API
  include Error::ErrorHandler

  before_action :ensure_authentication
  before_action :switch_schema

  private

  def ensure_authentication
    decoded_token = jwt_decode(request.headers['Authorization'] || '')

    @current_user = User.find_by!(id: decoded_token[0]['user_id'])
  rescue StandardError
    raise Errors::Http::Unauthorized, 'JWT Token inválido'
  end

  def switch_schema
    return if @current_user.nil?

    @tenant_name = Company.select(:tenant_name)
                          .find_by!(id: @current_user.company_id)
                          .tenant_name

    Tenant::Schema.new(@tenant_name).switch
  end

  def jwt_encode(payload = {})
    JWT.encode(payload, Rails.application.secrets.jwt_auth_key, 'HS256')
  end

  def jwt_decode(jwt_hash = '')
    JWT.decode(jwt_hash.split(' ').last, Rails.application.secrets.jwt_auth_key, true, algorithm: 'HS256')
  rescue StandardError
    raise Errors::Http::Unauthorized, 'JWT Token inválido'
  end
end
