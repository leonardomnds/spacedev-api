module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      # GET /users
      def index
        @users = paginate(
          search_users.not_admin
                      .by_company_id(@current_user.company_id)
        )

        render json: @users, each_serializer: Api::V1::Users::IndexSerializer
      end

      # GET /users/1
      def show
        render json: @user, serializer: Api::V1::Users::ShowSerializer
      end

      # POST /users
      def create
        @user = Business::Users::CreateService.new(params: create_params).call

        render json: @user, status: :created, serializer: Api::V1::Users::ShowSerializer
      end

      # PATCH/PUT /users/1
      def update
        @user = Business::Users::UpdateService.new(user: @user, params: user_params).call

        render json: @user, serializer: Api::V1::Users::ShowSerializer
      end

      # DELETE /users/1
      def destroy
        @user = Business::Users::DestroyService.new(user: @user).call

        render json: @user, serializer: Api::V1::Users::ShowSerializer
      end

      private

      def set_user
        @user = User.by_company_id(@current_user.company_id)
                    .find_by!(id: params[:id])
      end

      def search_users
        apply_scopes(User)
      end

      def create_params
        params.permit(:company_id, :name, :email, :password, :active)
      end

      def user_params
        params.permit(:email, :name, :active)
      end
    end
  end
end
