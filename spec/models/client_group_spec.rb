require 'rails_helper'

RSpec.describe ClientGroup, type: :model do
  describe 'associations' do
    it { should have_many(:clients).dependent(:nullify) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }

    # TODO: Test uniqueness validation with conditions
    # it { should validate_uniqueness_of(:description) }
  end
end
