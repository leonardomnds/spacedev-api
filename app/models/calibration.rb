class Calibration < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  validates :instrument_id, :date, presence: true

  belongs_to :instrument
end
