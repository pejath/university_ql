# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Group queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#createGroup' do
    let!(:lecturer) { create(:lecturer) }
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation createGroup($input: CreateGroupInput!) {
       createGroup(input: $input){
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "curatorId": lecturer.id,
        "departmentId": department.id,
        "course": 2,
        "specializationCode": 223,
        "formOfEducation": "EVENING"
      }}}

    it 'creates one group' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createGroup')).to eq(
        {'course'=>2, 'formOfEducation'=>'EVENING', 'specializationCode'=>223,
        'curator'=>{'id'=>'1'}, 'department'=>{'id'=>'2'}}
                                                   )
    end
  end

  describe '#updateGroup' do
    let!(:group) { create(:group, course: 3) }
    let!(:lecturer) { create(:lecturer) }

    let(:query) { <<~GQL }
      mutation updateGroup($input: UpdateGroupInput!) {
       updateGroup(input: $input){
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
        "id": 1,
        "curatorId": 2,
        "departmentId": 1,
        "course": 2,
        "specializationCode": 223,
        "formOfEducation": "CORRESPONDENCE"
      }}}

    it 'updates group' do
      expect(group.id).to eq(1)
      expect(group.curator_id).to eq(1)
      expect(group.department_id).to eq(2)
      expect(group.form_of_education).to eq('evening')
      expect(group.specialization_code).to eq(1)
      expect(result.dig('data', 'updateGroup')).to eq(
        {'course'=>2, 'formOfEducation'=>'CORRESPONDENCE', 'specializationCode'=>223,
        'curator'=>{'id'=>'2'}, 'department'=>{'id'=>'1'}}
                                                     )
    end
  end

  describe '#deleteGroup' do
    let!(:group) { create(:group, course: 1) }
    let(:query) { <<~GQL }
      mutation deleteGroup($input: DeleteGroupInput!) {
        deleteGroup(input: $input) {
         id
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "id": 1
      }}}

    it 'deletes group' do
      expect{ result }.to change { Group.count }.by(-1)
    end

    it 'deletes correct group' do
      expect(result.dig('data', 'deleteGroup')).to eq(
        { 'id'=>'1','course'=>1, 'formOfEducation'=>'EVENING', 'specializationCode'=>1,
        'curator'=>{'id'=>'1'}, 'department'=>{'id'=>'2'} }
                                                     )
    end
  end
end
