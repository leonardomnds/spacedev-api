module Api
  module V1
    class ClientsController < ApplicationController
      before_action :set_client, only: %i[show update destroy]

      # GET /clients
      def index
        @clients = paginate(Client.all)

        render json: @clients, each_serializer: Api::V1::Clients::IndexSerializer
      end

      # GET /clients/1
      def show
        render json: @client, serializer: Api::V1::Clients::ShowSerializer
      end

      # POST /clients
      def create
        @client = Business::Clients::CreateService.new(params: client_params).call

        render json: @client, serializer: Api::V1::Clients::ShowSerializer
      end

      # PATCH/PUT /clients/1
      def update
        @client = Business::Clients::UpdateService.new(client: @client, params: client_params).call

        render json: @client, serializer: Api::V1::Clients::ShowSerializer
      end

      # DELETE /clients/1
      def destroy
        @client = Business::Clients::DestroyService.new(client: @client).call

        render json: @client, serializer: Api::V1::Clients::ShowSerializer
      end

      private

      def set_client
        @client = Client.find_by!(id: params[:id])
      end

      def client_params
        params.permit(
          :cpf_cnpj, :company_name, :trading_name, :document_number, :email, :active
        )
      end
    end
  end
end
