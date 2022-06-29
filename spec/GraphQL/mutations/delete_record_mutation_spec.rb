# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department mutations' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}
  describe '#deleteDepartment' do
    let!(:mark) { create(:mark) }
    let!(:group) { create(:group) }
    let!(:lecture) { create(:lecture) }
    let!(:faculty) { create(:faculty) }
    let!(:student) { create(:student) }
    let!(:lecturer) { create(:lecturer) }
    let!(:subject) { create(:subject) }
    let!(:department) { create(:department) }

    let(:query) { <<~GQL }
      mutation deleteRecord($input: DeleteRecordInput!) {
        deleteRecord(input: $input) {
          ... on BaseObject{
                  id
                }
        }
      }
    GQL

    let(:variables) {
      { "input" => {}}}

    it 'deletes department' do
      variables['input']['recordId'] = make_global_id(department)
      expect{ result }.to change { Department.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(department)})
    end

    it 'deletes subject' do
      variables['input']['recordId'] = make_global_id(subject)
      expect{ result }.to change { Subject.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(subject)})
    end

    it 'deletes lecturer' do
      variables['input']['recordId'] = make_global_id(lecturer)
      expect{ result }.to change { Lecturer.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(lecturer)})
    end

    it 'deletes student' do
      variables['input']['recordId'] = make_global_id(student)
      expect{ result }.to change { Student.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(student)})
    end

    it 'deletes faculty' do
      variables['input']['recordId'] = make_global_id(faculty)
      expect{ result }.to change { Faculty.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(faculty)})
    end

    it 'deletes lecture' do
      variables['input']['recordId'] = make_global_id(lecture)
      expect{ result }.to change { Lecture.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(lecture)})
    end

    it 'deletes group' do
      variables['input']['recordId'] = make_global_id(group)
      expect{ result }.to change { Group.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(group)})
    end

    it 'deletes mark' do
      variables['input']['recordId'] = make_global_id(mark)
      expect{ result }.to change { Mark.count }.by(-1)
      expect(result.dig('data', 'deleteRecord')).to eq({'id'=>make_global_id(mark)})
    end
  end
end

