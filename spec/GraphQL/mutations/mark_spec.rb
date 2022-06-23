# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mark mutations' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#createMark' do
    let!(:student) { create(:student) }
    let!(:subject) { create(:subject) }
    let!(:lecturer) { create(:lecturer) }
    let(:query) { <<~GQL }
      mutation createMark($input: CreateMarkInput!) {
       createMark(input: $input){
         mark,
         student{ id },
         subject{ id },
         lecturer{ id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "value": 5,
        "studentId": make_global_id(student),
        "subjectId": make_global_id(subject),
        "lecturerId": make_global_id(lecturer)
      }}}

    it 'creates one mark' do
      expect { result }.to(change(Mark, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createMark')).to eq(
        { 'mark'=>5, 'student'=> { 'id'=>make_global_id(student) },
          'subject'=> { 'id'=>make_global_id(subject) },
          'lecturer'=> { 'id'=>make_global_id(lecturer) }
        }
                                                     )
    end
  end

  describe '#updateMark' do
    let!(:mark) { create(:mark) }
    let!(:student) { create(:student) }
    let!(:subject) { create(:subject) }
    let!(:lecturer) { create(:lecturer) }
    let(:query) { <<~GQL }
      mutation updateMark($input: UpdateMarkInput!) {
       updateMark(input: $input){
         id,
         mark,
         student{ id },
         subject{ id },
         lecturer{ id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "value": 5,
        "markId": make_global_id(mark),
        "studentId": make_global_id(student),
        "subjectId": make_global_id(subject),
        "lecturerId": make_global_id(lecturer)
      }}}

    it 'updates mark' do
      expect(mark.mark).to eq(1)
      expect(result.dig('data', 'updateMark')).to eq(
        { 'id'=>make_global_id(mark), 'mark'=>5,
          'student'=> { 'id'=>make_global_id(student) },
          'subject'=> { 'id'=>make_global_id(subject) },
          'lecturer'=> { 'id'=>make_global_id(lecturer) }}
                                                     )
    end
  end

  describe '#deleteMark' do
    let!(:mark) { create(:mark) }
    let(:query) { <<~GQL }
      mutation deleteMark($input: DeleteMarkInput!) {
        deleteMark(input: $input) {
         id,
         mark,
         student{ id },
         subject{ id },
         lecturer{ id }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "markId": make_global_id(mark)
      }}}

    it 'deletes mark' do
      expect{ result }.to change { Mark.count }.by(-1)
    end

    it 'deletes correct mark' do
      expect(result.dig('data', 'deleteMark')).to eq(
        { 'id'=>make_global_id(mark),
          'mark'=>1, 'student'=> { 'id'=>make_global_id(mark.student) },
          'subject'=> { 'id'=>make_global_id(mark.subject) },
          'lecturer'=> { 'id'=>make_global_id(mark.lecturer) }}
                                                     )
    end
  end
end

