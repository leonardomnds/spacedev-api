require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { Company.new(attributes_for(:company)) }

  describe 'associations' do
    it { should have_many(:users).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:cpf_cnpj) }
    it { should validate_presence_of(:tenant_name) }

    it { should validate_uniqueness_of(:tenant_name).case_insensitive }
  end

  describe 'callbacks' do
    context 'before_validation' do
      it 'should remove all non-numeric characters from cpf_cnpj' do
        company = build(:company, cpf_cnpj: '123.456.789-00')
        company.save

        expect(company.cpf_cnpj).to eq('12345678900')
      end

      it 'should downcase tenant_name' do
        company = build(:company, tenant_name: 'AnyCompany')
        company.save

        expect(company.tenant_name).to eq('anycompany')
      end
    end
  end
end
