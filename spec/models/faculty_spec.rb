
require 'rails_helper'

RSpec.describe Faculty, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:departments)}
    it { is_expected.to have_many(:lecturers).through(:departments)}
  end

  describe 'validations' do
    subject { FactoryBot.build(:faculty) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:formation_date).with_message('is invalid') }
    it { is_expected.to allow_value('2000.01.18').for(:formation_date)}
    it { is_expected.to_not allow_value('01.18').for(:formation_date)}
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end