require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:groups) }
    it { is_expected.to have_many(:lecturers_subjects) }
    it { is_expected.to have_many(:lecturers).through(:lecturers_subjects) }
    it { is_expected.to have_many(:marks).dependent(:delete_all) }
    it { is_expected.to have_many(:students).through(:marks) }
    it { is_expected.to have_many(:lectures) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:subject) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
