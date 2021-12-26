module Business
  module Clients
    class UpdateService
      def initialize(client:, params:)
        @client = client
        @params = params
      end

      def call
        update_client
        @client
      end

      private

      def update_client
        @client.update!(@params)
        @client.reload
      end
    end
  end
end
