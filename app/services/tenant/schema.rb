module Tenant
  class Schema
    def initialize(tenant_name)
      @tenant_name = tenant_name
    end

    def create
      create_tenant
    end

    def destroy
      destroy_tenant
    end

    def switch
      switch_tenant
    end

    private

    def create_tenant
      Apartment::Tenant.create(@tenant_name)
    end

    def destroy_tenant
      Apartment::Tenant.drop(@tenant_name)
    end

    def switch_tenant
      Apartment::Tenant.switch!(@tenant_name)
    end
  end
end
