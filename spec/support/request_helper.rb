module Request
  module JsonHelpers
    def response_body
      @response_body ||= JSON.parse(response.body.presence || 'null', symbolize_names: true)
    end

    def headers(user)
      return if user.nil?

      is_client = user.class == Client

      payload = { user_id: user.id, is_client: is_client, session_token: user.session_token, exp: 1.day.from_now.to_i }

      jwt = JWT.encode(payload, Rails.application.secrets.jwt_auth_key, 'HS256')

      @headers ||= request.headers['Authorization'] = "Bearer #{jwt}"
    end
  end
end
