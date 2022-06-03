
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'enum' do
    it { should define_enum_for(:form_of_education).with_values(%i[evening correspondence full_time])}
  end

  describe 'relations' do
    it { is_expected.to have_many(:lecturers).through(:lectures) }
    it { is_expected.to have_many(:lectures).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:lectures) }
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:curator).class_name('Lecturer').optional }
  end

  describe 'validations' do
    subject { FactoryBot.build(:group) }
    it { is_expected.to validate_presence_of(:course) }
    it { is_expected.to validate_presence_of(:curator_id) }
    it { is_expected.to validate_presence_of(:specialization_code) }
    it { is_expected.to validate_numericality_of(:curator_id) }
    it { is_expected.to validate_numericality_of(:specialization_code) }
    it { is_expected.to validate_numericality_of(:course).is_greater_than(0).is_less_than(6) }
    it { is_expected.to validate_uniqueness_of(:specialization_code) }
    it { is_expected.to validate_uniqueness_of(:curator_id) }
  end
end
