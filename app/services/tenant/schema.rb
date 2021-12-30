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

    def current
      current_tenant
    end

    def exists?
      tenant_exists?
    end

    def migrate
      run_migrations
    end

    private

    def create_tenant
      ActiveRecord::Base.connection
                        .execute("CREATE SCHEMA #{@tenant_name}")

      run_migrations
    end

    def destroy_tenant
      Apartment::Tenant.drop(@tenant_name)

      @tenant_name
    end

    def switch_tenant
      Apartment::Tenant.switch!(@tenant_name)

      @tenant_name
    end

    def current_tenant
      Apartment::Tenant.current
    end

    def tenant_exists?
      ActiveRecord::Base.connection
                        .execute(database_schemas_query)
                        .map { |row| row['nspname'] }
                        .count
                        .positive?
    end

    def run_migrations
      switch_tenant

      ActiveRecord::Base.connection.migration_context.migrate

      @tenant_name
    end

    def database_schemas_query
      "
        SELECT
          nspname
        FROM
          pg_catalog.pg_namespace
        WHERE
          nspname = '#{@tenant_name}'
      "
    end
  end
end
