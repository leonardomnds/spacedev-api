module Business
  module Calibrations
    class UpdateService
      def initialize(calibration:, params:)
        @calibration = calibration
        @params = params
      end

      def call
        update_calibration
        @calibration
      end

      private

      def update_calibration
        @calibration.update!(@params)
        @calibration.reload
      end
    end
  end
end
