module Api
  module V1
    class CalibrationsController < ApplicationController
      before_action :set_calibration, only: %i[show update destroy]

      # GET /calibrations
      def index
        @calibrations = paginate(
          Calibration.all
                     .preload(:instrument)
        )

        render json: @calibrations, each_serializer: Api::V1::Calibrations::IndexSerializer
      end

      # GET /calibrations/1
      def show
        render json: @calibration, serializer: Api::V1::Calibrations::ShowSerializer
      end

      # POST /calibrations
      def create
        @calibration = Business::Calibrations::CreateService.new(params: calibration_params).call

        render json: @calibration, status: :created, serializer: Api::V1::Calibrations::ShowSerializer
      end

      # PATCH/PUT /calibrations/1
      def update
        @calibration = Business::Calibrations::UpdateService.new(calibration: @calibration, params: calibration_params).call

        render json: @calibration, serializer: Api::V1::Calibrations::ShowSerializer
      end

      # DELETE /calibrations/1
      def destroy
        @calibration = Business::Calibrations::DestroyService.new(calibration: @calibration).call

        render json: @calibration, serializer: Api::V1::Calibrations::ShowSerializer
      end

      private

      def set_calibration
        @calibration = Calibration.find_by!(id: params[:id])
      end

      def calibration_params
        params.permit(:instrument_id, :date, :laboratory, :certificate_number)
      end
    end
  end
end
