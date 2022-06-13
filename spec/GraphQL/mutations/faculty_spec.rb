# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Faculty queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#createFaculty' do
    let(:query) { <<~GQL }
      mutation createFaculty($input: CreateFacultyInput!) {
       createFaculty(input: $input){
         name,
         formationDate,
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "name": "Biology",
        "formationDate":"1990-03-21"
      }}}

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
      mutation updateFaculty($input: UpdateFacultyInput!) {
       updateFaculty(input: $input){
         id,
         name,
         formationDate,
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "id": "1",
        "name": "UpdatedFaculty",
        "formationDate":"1990-03-21"
      }}}

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
      mutation deleteFaculty($input: DeleteFacultyInput!) {
        deleteFaculty(input: $input) {
          id
          name
          formationDate
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "id": 1
      }}}

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
