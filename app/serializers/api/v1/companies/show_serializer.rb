module Api
  module V1
    module Companies
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :company_name,
                   :trading_name,
                   :cpf_cnpj,
                   :tenant_name,
                   :admin_user,
                   :created_at,
                   :updated_at

        def admin_user
          User.find_by(company_id: object.id, is_admin: true)&.email
        end
      end
    end
  end
end
