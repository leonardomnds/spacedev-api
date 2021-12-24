module Errors
  module Http
    class HttpError < StandardError
      attr_reader :message, :status_code

      def initialize(message, status_code)
        @message = message
        @status_code = status_code
      end

      def to_s
        message
      end
    end
  end
end
