module Api
  module V1
    module Clients
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :cpf_cnpj,
                   :company_name,
                   :trading_name,
                   :document_number,
                   :email,
                   :phone,
                   :cel_phone,
                   :created_at,
                   :updated_at

        belongs_to :client_group, serializer: Api::V1::ClientGroups::ShowSerializer
      end
    end
  end
end
