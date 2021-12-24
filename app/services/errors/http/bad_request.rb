module Errors
  module Http
    class BadRequest < HttpError
      def initialize(message)
        super(message, :bad_request)
      end
    end
  end
end
