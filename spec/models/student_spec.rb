require 'rails_helper'

RSpec.describe Student, type: :model do
  let!(:student) { build(:student) }
  let!(:red_diploma_student) { create(:student, :with_red_diploma) }

  describe 'relations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to have_many(:marks).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:marks) }
    it { is_expected.to accept_nested_attributes_for(:marks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'class_scope' do
    describe '#red_diplomas' do
      it "shouldn't has that student" do
        expect(Student.red_diplomas).not_to include(student)
      end
      it 'should has that student' do
        expect(Student.red_diplomas).to include(red_diploma_student)
      end
    end
  end


  describe 'class_methods' do
    describe '#average_mark' do
      context "without marks student" do
        it 'returns 0.0' do
          expect(student.average_mark).to match(0.0)
        end
      end
      context "with only one mark" do
        it 'returns 5.0' do
          expect(red_diploma_student.average_mark).to match(5.0)
        end
      end
      context "with many marks" do
        it 'returns 4.5 with two marks' do
          red_diploma_student.marks << build(:mark, student_id: red_diploma_student.id, mark: 4)
          expect(red_diploma_student.average_mark).to match(4.5)
        end
      end
    end
  end
end
