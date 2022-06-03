require 'rails_helper'

RSpec.describe LecturersSubject, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:lecturer) }
    it { is_expected.to belong_to(:subject) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:lecturer_id) }
    it { is_expected.to validate_numericality_of(:lecturer_id) }
    it { is_expected.to validate_uniqueness_of(:lecturer_id).scoped_to(:subject_id) }
  end
end
