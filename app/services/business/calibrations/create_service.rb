module Business
  module Calibrations
    class CreateService
      def initialize(params:)
        @params = params
      end

      def call
        create_calibration
        @calibration
      end

      private

      def create_calibration
        @calibration = Calibration.create!(@params)
      end
    end
  end
end
