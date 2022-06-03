require 'rails_helper'

RSpec.describe LectureTime, type: :model do
  subject { LectureTime.new(beginning: '00:00') }

  describe 'relations' do
    it { is_expected.to have_many(:lectures) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:beginning) }
    it { is_expected.to validate_presence_of(:beginning) }
    it { is_expected.to allow_value('12:01').for(:beginning) }
  end

  describe 'class_methods' do
    describe '#formatted_time' do
      it 'returns time in correct format' do
        expect(subject.formatted_time).to eq('00:00')
      end
    end
  end
end
