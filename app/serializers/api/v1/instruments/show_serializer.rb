module Api
  module V1
    module Instruments
      class ShowSerializer < ActiveModel::Serializer
        attributes :id,
                   :client_id,
                   :tag,
                   :description,
                   :calibration_time,
                   :active,
                   :responsible,
                   :area,
                   :subarea,
                   :manufacturer,
                   :serial_number,
                   :range,
                   :resolution,
                   :created_at,
                   :updated_at,
                   :last_calibration_at,
                   :calibration_expires_at

        belongs_to :client, serializer: Api::V1::Clients::ShowSerializer

        def last_calibration_at
          return unless object.has_attribute?(:last_calibration_at)

          object.last_calibration_at
        end

        def calibration_expires_at
          return object.calibration_expires_at if object.has_attribute?(:calibration_expires_at)

          object.created_at.to_date + object.calibration_time.months
        end
      end
    end
  end
end
