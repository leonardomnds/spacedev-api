module Business
  module Instruments
    class UpdateService
      def initialize(instrument:, params:)
        @instrument = instrument
        @params = params
      end

      def call
        update_instrument
        @instrument
      end

      private

      def update_instrument
        @instrument.update!(@params)
        @instrument.reload
      end
    end
  end
end
