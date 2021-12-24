module Business
  module Companies
    class DestroyService
      def initialize(company:)
        @company = company
      end

      def call
        destroy_company
        destroy_tenant
        @company
      end

      private

      def destroy_company
        @company.destroy!
      end

      def destroy_tenant
        Tenant::Schema.new(@company.tenant_name).destroy
      rescue StandardError
        @company.restore(recursive: true)
      end
    end
  end
end
