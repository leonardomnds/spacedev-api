module Auth
  module EnsureAuthentication
    extend ActiveSupport::Concern

    included do
      before_action :ensure_authentication
      before_action :switch_schema
    end

    def ensure_authentication
      auth_key = 'Authorization'

      decoded_token = jwt_decode(request.cookies[auth_key] || request.headers[auth_key] || '')

      @current_user = User.find_by!(id: decoded_token.first['user_id'], session_token: decoded_token.first['session_token'])
    rescue StandardError
      raise Errors::Http::Unauthorized, invalid_jwt_message
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
      raise Errors::Http::Unauthorized, invalid_jwt_message
    end

    private

    def invalid_jwt_message
      I18n.t('controllers.concerns.error.ensure_authentication.invalid_jwt')
    end
  end
end
