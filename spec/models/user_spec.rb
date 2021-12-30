require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:company_id) }

    # TODO: Test uniqueness validation with conditions
    # it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'scopes' do
    subject(:model) { described_class }

    context 'not_admin' do
      let!(:user) { create(:user) }
      let!(:admin_user) { create(:admin_user) }

      it { expect(model.not_admin).to eq([user]) }
    end

    context 'by_company_id' do
      let!(:company_1) { create(:company, tenant_name: Faker::Lorem.word) }
      let!(:company_2) { create(:company, tenant_name: Faker::Lorem.word) }

      let!(:user_1) { create(:user, company: company_1) }
      let!(:user_2) { create(:user, company: company_2) }

      it { expect(model.by_company_id(company_1.id)).to eq([user_1]) }
      it { expect(model.by_company_id(company_2.id)).to eq([user_2]) }
    end
  end
end
