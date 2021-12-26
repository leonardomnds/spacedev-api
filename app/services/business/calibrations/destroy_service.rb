module Business
  module Calibrations
    class DestroyService
      def initialize(calibration:)
        @calibration = calibration
      end

      def call
        destroy_calibration
        @calibration
      end

      private

      def destroy_calibration
        @calibration.destroy!
      end
    end
  end
end
