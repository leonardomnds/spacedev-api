module Api
  module V1
    class InstrumentsController < ApplicationController
      before_action :set_instrument, only: %i[update destroy]

      # GET /instruments
      def index
        @instruments = paginate(Instrument.with_calibration_data)

        render json: @instruments, each_serializer: Api::V1::Instruments::IndexSerializer
      end

      # GET /instruments/1
      def show
        @instrument = Instrument.with_calibration_data
                                .find_by!(id: params[:id])

        render json: @instrument, serializer: Api::V1::Instruments::ShowSerializer
      end

      # POST /instruments
      def create
        @instrument = Business::Instruments::CreateService.new(params: create_params).call

        render json: @instrument, status: :created, serializer: Api::V1::Instruments::ShowSerializer
      end

      # PATCH/PUT /instruments/1
      def update
        @instrument = Business::Instruments::UpdateService.new(instrument: @instrument, params: create_params).call

        render json: @instrument, serializer: Api::V1::Instruments::ShowSerializer
      end

      # DELETE /instruments/1
      def destroy
        @instrument = Business::Instruments::DestroyService.new(instrument: @instrument).call

        render json: @instrument, serializer: Api::V1::Instruments::ShowSerializer
      end

      private

      def set_instrument
        @instrument = Instrument.find_by!(id: params[:id])
      end

      def create_params
        params.permit(
          :client_id, :tag, :description, :calibration_time, :responsible,
          :area, :subarea, :manufacturer, :serial_number, :range, :resolution,
          :active
        )
      end

      def instrument_params
        create_params.except(:client_id)
      end
    end
  end
end
