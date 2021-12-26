module Business
  module Instruments
    class DestroyService
      def initialize(instrument:)
        @instrument = instrument
      end

      def call
        destroy_instrument
        @instrument
      end

      private

      def destroy_instrument
        @instrument.destroy!
      end
    end
  end
end
