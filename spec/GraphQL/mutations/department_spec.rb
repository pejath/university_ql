# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#createDepartment' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      mutation createDepartment {
       createDepartment(input:{name: "Biology", departmentType: Interfacult, formationDate:"1990-03-21", facultyId:1}){
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
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createDepartment')).to eq(
        {'departmentType'=>'Interfacult', 'faculty'=>{'id'=>'1'}, 'formationDate'=>'1990-03-21', 'name'=>'Biology'}
                                                        )
    end
  end

  describe '#updateDepartment' do
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation updateDepartment {
       updateDepartment(input:{id: 1, name: "UpdatedDepartment", departmentType: Military, formationDate:"1990-03-21", facultyId:1}){
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

    it 'updates department' do
      expect(department.id).to eq(1)
      expect(department.name).to eq('department_1')
      expect(department.department_type).to eq('Basic')
      expect(department.formation_date.to_s).to eq('2002-12-20')
      expect(result.dig('data', 'updateDepartment')).to eq(
        { 'id'=>'1','departmentType'=>'Military', 'faculty'=>{'id'=>'1'}, 'formationDate'=>'1990-03-21', 'name'=>'UpdatedDepartment'}
                                                        )
    end
  end

  describe '#deleteDepartment' do
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation createDepartment {
        deleteDepartment(input: {id: 1}) {
          name
          departmentType
          formationDate
          faculty {
            id
          }
        }
      }
    GQL

    it 'deletes department' do
      expect{ result }.to change { Department.count }.by(-1)
    end

    it 'deletes correct department' do
      expect(result.dig('data', 'deleteDepartment')).to eq(
        {'departmentType'=>'Basic', 'faculty'=>{'id'=>'1'}, 'formationDate'=>'2002-12-20', 'name'=>'department_1'}
                                                        )
    end
  end
end
