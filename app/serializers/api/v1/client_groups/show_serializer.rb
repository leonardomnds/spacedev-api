module Api
  module V1
    module ClientGroups
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :description,
                   :created_at,
                   :updated_at,
                   :client_count

        def client_count
          Client.where(client_group_id: object.id).count
        end
      end
    end
  end
end
