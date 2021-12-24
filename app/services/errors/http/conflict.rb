module Errors
  module Http
    class Conflict < HttpError
      def initialize(message)
        super(message, :conflict)
      end
    end
  end
end
