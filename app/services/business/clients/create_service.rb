module Business
  module Clients
    class CreateService
      def initialize(params:)
        @params = params
      end

      def call
        create_client
        @client
      end

      private

      def create_client
        @client = Client.create!(@params)
      end
    end
  end
end
