# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#createStudent' do
    let(:group) { create(:group) }
    let(:query) { <<~GQL }
      mutation createStudent($input: CreateStudentInput!) {
       createStudent(input: $input){
         name,
         group { id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "name": "Nikita",
        "groupId": group.id
      }}}

    it 'creates one student' do
      expect { result }.to(change(Student, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createStudent')).to eq(
        { 'name'=>'Nikita', 'group'=>{'id'=>group.id.to_s} }
                                                     )
    end
  end

  describe '#updateStudent' do
    let(:group) { create(:group) }
    let!(:student) { create(:student) }
    let(:query) { <<~GQL }
      mutation updateStudent($input: UpdateStudentInput!) {
       updateStudent(input: $input){
         id,
         name,
         group { id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "id": student.id,
        "name": "Nikita",
        "groupId": group.id
      }}}

    it 'updates student' do
      expect(student.id).to eq(1)
      expect(student.name).not_to eq('Nikita')
      expect(result.dig('data', 'updateStudent')).to eq(
        {'id'=>student.id.to_s, 'name'=>'Nikita', 'group'=>{'id'=>group.id.to_s} }
                                                     )
    end
  end

  describe '#deleteStudent' do
    let!(:student) { create(:student) }
    let(:query) { <<~GQL }
      mutation deleteStudent($input: DeleteStudentInput!) {
        deleteStudent(input: $input) {
         id
         name
         group { id }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "id": student.id
      }}}

    it 'deletes student' do
      expect{ result }.to change { Student.count }.by(-1)
    end

    it 'deletes correct student' do
      expect(result.dig('data', 'deleteStudent')).to eq(
        { 'id'=>student.id.to_s, 'name'=>student.name, "group"=>{"id"=>student.group.id.to_s} }
                                                     )
    end
  end
end
