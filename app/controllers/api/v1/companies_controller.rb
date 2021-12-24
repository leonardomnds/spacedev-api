module Api
  module V1
    class CompaniesController < ApplicationController
      skip_before_action :ensure_authentication, :switch_schema

      before_action :set_company, only: %i[show update destroy]

      # GET /companies
      def index
        @companies = paginate(apply_scopes(Company), per_page: 20)

        render json: @companies, each_serializer: Api::V1::Companies::IndexSerializer
      end

      # GET /companies/1
      def show
        render json: @company, serializer: Api::V1::Companies::ShowSerializer
      end

      # POST /companies
      def create
        @company = Business::Companies::CreateService.new(params: create_params).call

        render json: @company, status: :created, serializer: Api::V1::Companies::ShowSerializer
      end

      # PATCH/PUT /companies/1
      def update
        @company = Business::Companies::UpdateService.new(company: @company, params: company_params).call

        render json: @company, serializer: Api::V1::Companies::ShowSerializer
      end

      # DELETE /companies/1
      def destroy
        @company = Business::Companies::DestroyService.new(company: @company).call

        render json: @company, serializer: Api::V1::Companies::ShowSerializer
      end

      private

      def set_company
        @company = Company.find_by!(id: params[:id])
      end

      def create_params
        params.permit(:company_name, :trading_name, :cpf_cnpj, :tenant_name)
      end

      def company_params
        params.permit(:company_name, :trading_name, :cpf_cnpj)
      end
    end
  end
end
