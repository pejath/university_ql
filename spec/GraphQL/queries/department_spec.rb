# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

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
        { 'id' => make_global_id(department[0]), 'name' => 'department_1', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'name' => 'faculty_1', 'formationDate' => '2002-12-20' } },
        { 'id' =>  make_global_id(department[1]), 'name' => 'department_2', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'name' => 'faculty_2', 'formationDate' => '2002-12-20' } }
                                                      ])
    end
  end

  describe '#department(id)' do
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      query department($id: ID!){
        node(id: $id){
          ... on Department{
            id,
            name,
            departmentType,
            formationDate
            faculty {
              name
              formationDate
            }
          }
        }
      }
    GQL

    let(:variables) { { "id": make_global_id(department) } }

    it 'returns one department' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        { 'id' => make_global_id(department), 'name' => 'department_1', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'name' => 'faculty_1', 'formationDate' => '2002-12-20' } }
                                                  )
    end
  end
end
