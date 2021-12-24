module Business
  module Companies
    class CreateService
      def initialize(params:)
        @params = params
      end

      def call
        validate_tenant_name
        create_company
        create_admin_user
        create_tenant
        @company
      end

      private

      def create_company
        @company = Company.create!(@params)
      end

      def create_admin_user
        User.create!(admin_user_params)
      end

      def create_tenant
        Tenant::Schema.new(@company.tenant_name).create
      end

      def admin_user_params
        {
          name: "ADMIN - #{@company.tenant_name}",
          email: "admin_#{@company.tenant_name}@spacedev.com",
          password: Rails.application.secrets.default_admin_user_pass.to_s,
          company_id: @company.id,
          active: true,
          is_admin: true
        }
      end

      def validate_tenant_name
        raise ::Errors::Http::BadRequest, 'Obrigatório informar um Tenant' if @params[:tenant_name].blank?

        raise ::Errors::Http::Conflict, 'Tenant já existe' if Company.exists?(tenant_name: @params[:tenant_name])
      end
    end
  end
end
