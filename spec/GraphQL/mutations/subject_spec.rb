# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subject queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#createSubject' do
    let(:query) { <<~GQL }
      mutation createSubject($input: CreateSubjectInput!) {
       createSubject(input: $input){
         name
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "name": "Biology",
      }}}

    it 'creates one subject' do
      expect { result }.to(change(Subject, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createSubject')).to eq(
        { 'name'=>'Biology' }
                                                     )
    end
  end

  describe '#updateSubject' do
    let!(:subject) { create(:subject) }
    let(:query) { <<~GQL }
      mutation updateSubject($input: UpdateSubjectInput!) {
       updateSubject(input: $input){
         id,
         name
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "id": subject.id,
        "name": "Math"
      }}}

    it 'updates subject' do
      expect(subject.id).to eq(1)
      expect(subject.name).to eq('subject_1')
      expect(result.dig('data', 'updateSubject')).to eq(
        { 'id'=>subject.id.to_s, 'name'=>'Math' }
                                                     )
    end
  end

  describe '#deleteSubject' do
    let!(:subject) { create(:subject) }
    let(:query) { <<~GQL }
      mutation deleteSubject($input: DeleteSubjectInput!) {
        deleteSubject(input: $input) {
          id
          name
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "id": subject.id
      }}}

    it 'deletes subject' do
      expect{ result }.to change { Subject.count }.by(-1)
    end

    it 'deletes correct subject' do
      expect(result.dig('data', 'deleteSubject')).to eq(
        { 'id'=>subject.id.to_s, 'name'=>'subject_1' }
                                                     )
    end
  end
end
