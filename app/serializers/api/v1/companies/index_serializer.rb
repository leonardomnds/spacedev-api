module Api
  module V1
    module Companies
      class IndexSerializer < ActiveModel::Serializer
        attributes :id,
                   :company_name,
                   :trading_name,
                   :cpf_cnpj,
                   :tenant_name,
                   :created_at
      end
    end
  end
end
