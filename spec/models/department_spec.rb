require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'enum' do
    it { should define_enum_for(:department_type).with_values(%i[Interfacult Basic Military]) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:lecturers) }
    it { is_expected.to have_many(:groups) }
    it { is_expected.to belong_to(:faculty) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:department) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:formation_date).with_message('is invalid') }
    it { is_expected.to allow_value('2000.01.18').for(:formation_date) }
    it { is_expected.to_not allow_value('01.18').for(:formation_date) }
    it { is_expected.to validate_uniqueness_of(:name)}
  end
end
