# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#departments' do
    let!(:department) { FactoryBot.create_list(:department, 2) }
    let(:query) { <<~GQL }
      query allDepartments{
        departments{
          id,
          name,
          departmentType,
          formationDate
          faculty {
            id
            name
            formationDate
          }
        }
      }
    GQL

    it 'returns all departments' do
      data = result.dig('data', 'departments')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'departments')).to eq([
        { 'id' => '1', 'name' => 'department_1', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'id' => '1', 'name' => 'faculty_1', 'formationDate' => '2002-12-20' } },
        { 'id' => '2', 'name' => 'department_2', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'id' => '2', 'name' => 'faculty_2', 'formationDate' => '2002-12-20' } }
                                                      ])
    end
  end

  describe '#department(id)' do
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      query department($id: ID!){
        department(id: $id){
          id,
          name,
          departmentType,
          formationDate
          faculty {
            id
            name
            formationDate
          }
        }
      }
    GQL

    let(:variables) { {"id": department.id} }

    it 'returns one department' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'department')).to eq(
        { 'id' => '1', 'name' => 'department_1', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'id' => '1', 'name' => 'faculty_1', 'formationDate' => '2002-12-20' } }
                                                  )
    end
  end
end
