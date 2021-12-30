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
      render_error(
        status: :not_found,
        message: I18n.t('controllers.concerns.error.error_handler.not_found', model: exception.model)
      )
    end

    def render_unprocessable_entity(exception)
      render_error(
        status: :unprocessable_entity,
        message: I18n.t('controllers.concerns.error.error_handler.unprocessable_entity'),
        errors: exception.record.errors
      )
    end

    def render_http_error(exception)
      render_error(
        status: exception.status_code,
        message: exception.message
      )
    end

    def render_internal_server_error(exception)
      render_error(
        status: :internal_server_error,
        message: I18n.t('controllers.concerns.error.error_handler.internal_server_error'),
        errors: exception.message
      )
    end
  end
end
