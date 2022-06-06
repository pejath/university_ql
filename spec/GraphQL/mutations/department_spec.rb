# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#createDepartment' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation createDepartment {
        createDepartment(input:{name: "Biology", departmentType: 1, formationDate:"1990-03-21", facultyId:1}){
          id,
          name,
          departmentType,
          formationDate,
          faculty {
            id
            }
          }
        }
    GQL

    it 'creates one department' do
      data = result.dig('data')
      puts data
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createDepartment')).to eq(
        { 'id' => '1', 'name' => 'Biology', 'departmentType' => 1, 'formationDate' => '1990-01-21',
        'faculty' => { 'id' => '1'} }
                                                  )
    end
  end
end
