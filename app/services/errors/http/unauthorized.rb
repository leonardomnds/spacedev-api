module Errors
  module Http
    class Unauthorized < HttpError
      def initialize(message)
        super(message, :unauthorized)
      end
    end
  end
end
