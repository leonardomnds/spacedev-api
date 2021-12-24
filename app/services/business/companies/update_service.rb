module Business
  module Companies
    class UpdateService
      def initialize(company:, params:)
        @company = company
        @params = params
      end

      def call
        remove_tenant_name_from_params
        update_company
        @company
      end

      private

      def update_company
        @company.update!(@params)
        @company.reload
      end

      def remove_tenant_name_from_params
        @params.delete :tenant_name
      end
    end
  end
end
