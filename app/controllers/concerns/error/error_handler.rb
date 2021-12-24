module Error
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError, with: :render_internal_server_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
      rescue_from ::Errors::Http::HttpError, with: :render_http_error
    end

    def render_error(status:, message: nil, errors: nil)
      body = { message: message } if message.present?

      body[:errors] = errors if errors.present?

      render json: body || '', status: status
    end

    private

    def render_not_found(exception)
      render_error(status: :not_found, message: "Recurso não encontrado para os parâmetros informados: #{exception.model}")
    end

    def render_unprocessable_entity(exception)
      render_error(status: :unprocessable_entity, message: 'Não foi possível concluir essa operação', errors: exception.record.errors)
    end

    def render_http_error(exception)
      render_error(status: exception.status_code, message: exception.message)
    end

    def render_internal_server_error(exception)
      render_error(status: :internal_server_error, message: 'Ocorreu um erro interno no servidor', errors: exception.message)
    end
  end
end
