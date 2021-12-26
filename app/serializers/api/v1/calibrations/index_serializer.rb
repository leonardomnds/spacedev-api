module Api
  module V1
    module Calibrations
      class IndexSerializer < ActiveModel::Serializer
        attributes :id,
                   :date,
                   :laboratory,
                   :certificate_number,
                   :created_at

        belongs_to :instrument, serializer: Api::V1::Instruments::IndexSerializer
      end
    end
  end
end
