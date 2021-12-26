module Api
  module V1
    module Clients
      class IndexSerializer < ActiveModel::Serializer
        attributes :id,
                   :cpf_cnpj,
                   :company_name,
                   :trading_name,
                   :document_number,
                   :email,
                   :phone,
                   :cel_phone,
                   :client_group_id,
                   :created_at
      end
    end
  end
end
