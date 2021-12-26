module Api
  module V1
    class ClientGroupsController < ApplicationController
      before_action :set_client_group, only: %i[show update destroy]

      # GET /client_groups
      def index
        @client_groups = paginate(ClientGroup.all)

        render json: @client_groups, each_serializer: Api::V1::ClientGroups::IndexSerializer
      end

      # GET /client_groups/1
      def show
        render json: @client_group
      end

      # POST /client_groups
      def create
        @client_group = ClientGroup.create!(client_group_params)

        render json: @client_group, status: :created, serializer: Api::V1::ClientGroups::ShowSerializer
      end

      # PATCH/PUT /client_groups/1
      def update
        @client_group.update!(client_group_params)

        render json: @client_group, serializer: Api::V1::ClientGroups::ShowSerializer
      end

      # DELETE /client_groups/1
      def destroy
        @client_group.destroy!

        render json: @client_group, serializer: Api::V1::ClientGroups::ShowSerializer
      end

      private

      def set_client_group
        @client_group = ClientGroup.find_by(id: params[:id])
      end

      def client_group_params
        params.permit(:description, :deleted_at)
      end
    end
  end
end
