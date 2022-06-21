# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department mutations' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#createDepartment' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation createDepartment($input: CreateDepartmentInput!) {
       createDepartment(input: $input){
         name,
         departmentType,
         formationDate,
         faculty {
           id
           }
         }
       }
    GQL

    let(:variables) {
      { "input" => {
      "name": "Biology",
      "departmentType": "INTERFACULT",
      "formationDate": "1990-03-21",
      "facultyId": make_global_id(faculty)
    }}}

    it 'creates one department' do
      expect { result }.to(change(Department, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createDepartment')).to eq(
        {'departmentType'=>'INTERFACULT', 'faculty'=>{'id'=>make_global_id(faculty)}, 'formationDate'=>'1990-03-21', 'name'=>'Biology'}
                                                        )
    end
  end

  describe '#updateDepartment' do
    let(:department) { create(:department) }
    let(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation updateDepartment($input: UpdateDepartmentInput!) {
       updateDepartment(input: $input){
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

    let(:variables) {
      { "input" => {
        "departmentId": make_global_id(department),
        "name": "UpdatedDepartment",
        "departmentType": "MILITARY",
        "formationDate": "1990-03-21",
        "facultyId": make_global_id(faculty)
      }}}

    it 'updates department' do
      expect(department.id).to eq(1)
      expect(department.name).to eq('department_1')
      expect(department.department_type).to eq('Basic')
      expect(department.formation_date.to_s).to eq('2002-12-20')
      expect(result.dig('data', 'updateDepartment')).to eq(
        { 'id'=>make_global_id(department),'departmentType'=>'MILITARY', 'faculty'=>{'id'=>make_global_id(faculty)}, 'formationDate'=>'1990-03-21', 'name'=>'UpdatedDepartment'}
                                                        )
    end
  end

  describe '#deleteDepartment' do
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation createDepartment($input: DeleteDepartmentInput!) {
        deleteDepartment(input: $input) {
          name
          departmentType
          formationDate
          faculty {
            id
          }
        }
      }
    GQL

    let(:variables) {
      { "input" => {
        "departmentId": make_global_id(department)
      }}}

    it 'deletes department' do
      expect{ result }.to change { Department.count }.by(-1)
    end

    it 'deletes correct department' do
      expect(result.dig('data', 'deleteDepartment')).to eq(
        {'departmentType'=>'BASIC', 'faculty'=>{'id'=>make_global_id(department.faculty)}, 'formationDate'=>'2002-12-20', 'name'=>'department_1'}
                                                        )
    end
  end
end
