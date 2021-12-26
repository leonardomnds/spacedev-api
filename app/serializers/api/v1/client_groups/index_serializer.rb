module Api
  module V1
    module ClientGroups
      class IndexSerializer < ActiveModel::Serializer
        attributes :id,
                   :description
      end
    end
  end
end
