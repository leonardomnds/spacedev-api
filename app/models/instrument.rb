class Instrument < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  validates :tag, :description, :calibration_time, presence: true
  validates :calibration_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :client

  has_many :calibrations, dependent: :destroy, inverse_of: :instrument

  scope :active, -> { where(active: true) }

  scope :with_calibration_data, lambda {
    left_joins(:calibrations).select('MAX(calibrations.date) AS last_calibration_at')
                             .select('COALESCE(MAX(calibrations.date), instruments.created_at)::DATE + MAKE_INTERVAL(MONTHS => instruments.calibration_time) AS calibration_expires_at')
                             .select(Instrument.attribute_names)
                             .group(Instrument.attribute_names)
  }

  scope :expired_calibration, lambda {
    with_calibration_data.having('COALESCE(MAX(calibrations.date), instruments.created_at)::DATE + MAKE_INTERVAL(MONTHS => instruments.calibration_time) < ?', Time.zone.today)
  }

  scope :calibration_expires_in, lambda { |number_of_days|
    with_calibration_data.having('COALESCE(MAX(calibrations.date), instruments.created_at)::DATE + MAKE_INTERVAL(MONTHS => instruments.calibration_time) BETWEEN :from AND :until',
                                 {
                                   from: Time.zone.today,
                                   until: Time.zone.today + number_of_days.to_i.days
                                 })
  }
end
