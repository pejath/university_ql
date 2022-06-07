# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Faculty queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#createFaculty' do
    let(:query) { <<~GQL }
      mutation createFaculty {
       createFaculty(input:{name: "Biology", formationDate:"1990-03-21"}){
         name,
         formationDate,
         }
       }
    GQL

    it 'creates one faculty' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createFaculty')).to eq(
        { 'formationDate'=>'1990-03-21', 'name'=>'Biology' }
                                                     )
    end
  end

  describe '#updateFaculty' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation updateFaculty {
       updateFaculty(input:{id: 1, name: "UpdatedFaculty", formationDate:"1990-03-21"}){
         id,
         name,
         formationDate,
         }
       }
    GQL

    it 'updates faculty' do
      expect(faculty.id).to eq(1)
      expect(faculty.name).to eq('faculty_1')
      expect(faculty.formation_date.to_s).to eq('2002-12-20')
      expect(result.dig('data', 'updateFaculty')).to eq(
        { 'id'=>'1', 'formationDate'=>'1990-03-21', 'name'=>'UpdatedFaculty'}
                                                     )
    end
  end

  describe '#deleteFaculty' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation deleteFaculty {
        deleteFaculty(input: {id: 1}) {
          id
          name
          formationDate
        }
      }
    GQL

    it 'deletes faculty' do
      expect{ result }.to change { Faculty.count }.by(-1)
    end

    it 'deletes correct faculty' do
      expect(result.dig('data', 'deleteFaculty')).to eq(
        { 'id'=>'1', 'formationDate'=>'2002-12-20', 'name'=>'faculty_1'}
                                                     )
    end
  end
end
