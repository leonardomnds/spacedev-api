module Api
  module V1
    module Users
      class IndexSerializer < ActiveModel::Serializer
        attributes :id,
                   :name,
                   :email,
                   :active,
                   :company_id,
                   :created_at,
                   :updated_at
      end
    end
  end
end
