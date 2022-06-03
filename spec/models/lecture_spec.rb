require 'rails_helper'

RSpec.describe Lecture, type: :model do
  describe 'enum' do
    it { should define_enum_for(:weekday).with_values(%i[Monday Tuesday Wednesday Thursday Friday Saturday])}
  end

  describe 'relations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:lecture_time) }
    it { is_expected.to belong_to(:lecturer) }
    it { is_expected.to belong_to(:subject) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:lecture) }
    it { is_expected.to validate_presence_of(:corpus) }
    it { is_expected.to validate_presence_of(:group_id) }
    it { is_expected.to validate_presence_of(:auditorium) }
    it { is_expected.to validate_numericality_of(:corpus) }
    it { is_expected.to validate_numericality_of(:auditorium) }
    it { is_expected.to validate_uniqueness_of(:auditorium).scoped_to(:corpus, :lecture_time_id) }
    it { is_expected.to validate_uniqueness_of(:group_id).scoped_to(:lecture_time_id, :weekday) }
  end
end
