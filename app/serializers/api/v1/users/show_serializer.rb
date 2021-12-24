module Api
  module V1
    module Users
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :name,
                   :email,
                   :active,
                   :created_at,
                   :updated_at

        belongs_to :company, serializer: Api::V1::Companies::IndexSerializer
      end
    end
  end
end
