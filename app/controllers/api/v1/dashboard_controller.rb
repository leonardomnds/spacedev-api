module Api
  module V1
    class DashboardController < ApplicationController
      def active_clients
        render json: { count: Client.active.count }
      end

      def active_instruments
        render json: { count: Instrument.active.count }
      end

      def expired_calibrations
        render json: { count: Instrument.expired_calibration.to_a.count }
      end

      def calibrations_to_expire
        render json: { count: Instrument.calibration_expires_in(params[:number_of_days].presence || 0).to_a.count }
      end

      def client_number_evolution
        data = Reports::Clients::ClientNumberEvolution.new(start_date: params[:start_date], end_date: params[:end_date]).call

        render json: data
      end

      def instrument_number_evolution
        data = Reports::Instruments::InstrumentNumberEvolution.new(start_date: params[:start_date], end_date: params[:end_date]).call

        render json: data
      end
    end
  end
end
