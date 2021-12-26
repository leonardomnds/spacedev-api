module Business
  module Instruments
    class CreateService
      def initialize(params:)
        @params = params
      end

      def call
        create_instrument
        @instrument
      end

      private

      def create_instrument
        @instrument = Instrument.create!(@params)
      end
    end
  end
end
