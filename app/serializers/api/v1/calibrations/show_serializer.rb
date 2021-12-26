module Api
  module V1
    module Calibrations
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :date,
                   :laboratory,
                   :certificate_number,
                   :created_at,
                   :updated_at

        belongs_to :instrument, serializer: Api::V1::Instruments::ShowSerializer
      end
    end
  end
end
