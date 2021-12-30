require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'associations' do
    it { should belong_to(:client_group).optional }
    it { should have_many(:instruments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:cpf_cnpj) }
    it { should validate_presence_of(:company_name) }

    # TODO: Test uniqueness validation with conditions
    # it { should validate_uniqueness_of(:cpf_cnpj) }
  end

  describe 'callbacks' do
    context 'before_validation' do
      it 'should remove all non-numeric characters from cpf_cnpj' do
        client = build(:client, cpf_cnpj: '123.456.789-00')
        client.save

        expect(client.cpf_cnpj).to eq('12345678900')
      end
    end
  end

  describe 'scopes' do
    subject(:model) { described_class }

    context 'active' do
      let!(:client) { create(:client) }
      let!(:inactive_client) { create(:inactive_client) }

      it { expect(model.active).to eq([client]) }
    end

    context 'by_cpf_cnpj' do
      let!(:client_1) { create(:client) }
      let!(:client_2) { create(:client) }

      it { expect(model.by_cpf_cnpj(client_1.cpf_cnpj)).to eq([client_1]) }
      it { expect(model.by_cpf_cnpj(client_2.cpf_cnpj)).to eq([client_2]) }
    end
  end
end
