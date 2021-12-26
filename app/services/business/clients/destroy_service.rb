module Business
  module Clients
    class DestroyService
      def initialize(client:)
        @client = client
      end

      def call
        destroy_client
        @client
      end

      private

      def destroy_client
        @client.destroy!
      end
    end
  end
end
