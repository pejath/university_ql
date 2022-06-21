# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecturer mutations' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#createLecturer' do
    let(:department) {create(:department)}
    let(:query) { <<~GQL }
      mutation createLecturer($input: CreateLecturerInput!) {
       createLecturer(input: $input){
         name,
         academicDegree,
         department { id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "name": "Jason",
        "academicDegree": 2,
        "departmentId": make_global_id(department)
      }}}

    it 'creates one lecturer' do
      expect { result }.to(change(Lecturer, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createLecturer')).to eq(
        { "name"=>"Jason", "academicDegree"=>2, "department"=>{"id"=>make_global_id(department)} }
                                                      )
    end
  end

  describe '#updateLecturer' do
    let!(:lecturer) { create(:lecturer) }
    let(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation updateLecturer($input: UpdateLecturerInput!) {
       updateLecturer(input: $input){
         id,
         name,
         academicDegree,
         department { id }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "lecturerId": make_global_id(lecturer),
        "name": "Statham",
        "departmentId": make_global_id(department),
        "academicDegree": 3
      }}}

    it 'updates lecturer' do
      expect(lecturer.id).to eq(1)
      expect(lecturer.name).not_to eq('Statham')
      expect(lecturer.academic_degree.to_s).to eq('1')
      expect(result.dig('data', 'updateLecturer')).to eq(
        { "id"=>make_global_id(lecturer),"name"=>"Statham", "academicDegree"=> 3, "department"=>{"id"=>make_global_id(department)} }
                                                      )
    end
  end

  describe '#deleteLecturer' do
    let!(:lecturer) { create(:lecturer) }
    let(:query) { <<~GQL }
      mutation deleteLecturer($input: DeleteLecturerInput!) {
        deleteLecturer(input: $input) {
         id,
         name,
         academicDegree,
         department { id }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "lecturerId": make_global_id(lecturer)
      }}}

    it 'deletes lecturer' do
      expect{ result }.to change { Lecturer.count }.by(-1)
    end

    it 'deletes correct lecturer' do
      expect(result.dig('data', 'deleteLecturer')).to eq(
        { 'id'=>make_global_id(lecturer), 'department'=> {'id'=>make_global_id(lecturer.department)}, 'academicDegree'=>1, 'name'=>lecturer.name}
                                                     )
    end
  end
end
