require 'rails_helper'

RSpec.describe Mark, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:student)}
    it { is_expected.to belong_to(:subject)}
    it { is_expected.to belong_to(:lecturer).optional}
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:mark) }
    it { is_expected.to validate_numericality_of(:mark).is_greater_than(0).is_less_than(6) }
  end
end
