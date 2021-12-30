require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
    it { should have_many(:calibrations).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:tag) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:calibration_time) }
    it { should validate_numericality_of(:calibration_time).is_greater_than_or_equal_to(0) }
  end

  describe 'scopes' do
    subject(:model) { described_class }

    context 'with_calibration_data' do
      let!(:calibration) { create(:calibration) }

      it { expect(model.with_calibration_data.first[:last_calibration_at]).to eq(calibration.date) }
      it { expect(model.with_calibration_data.first[:calibration_expires_at]).to eq(calibration.date + calibration.instrument.calibration_time.months) }
    end

    # context 'expired_calibration' do
    #   let!(:instrument_1) { create(:instrument, calibration_time: 1) }
    #   let!(:instrument_2) { create(:instrument, calibration_time: 1) }

    #   let!(:calibration_1) { create(:calibration, instrument: instrument_1, date: 60.days.ago.to_date) }
    #   let!(:calibration_2) { create(:calibration, instrument: instrument_1, date: 15.days.ago.to_date) }

    #   it { expect(model.expired_calibration.first).to eq([calibration_2]) }
    # end
  end
end
