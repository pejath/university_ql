# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#departments' do
    let!(:department1) { FactoryBot.create(:department) }
    let!(:department2) { FactoryBot.create(:department) }
    let!(:department3) { FactoryBot.create(:department) }
    let!(:department4) { FactoryBot.create(:department) }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredDepartments($filter: [FilterInput!]){
          departments(filter: $filter){
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

      let(:variables) {
        { "filter" => [{
          "key": 'name',
          "filter": '1'
        }]}}

      it 'returns one department' do
        data = result.dig('data', 'departments')
        expect(data.count).to eq(1)
      end

      it 'returns correct department' do
        expect(result.dig('data', 'departments')).to eq([
          { 'id' => make_global_id(department1), 'name' => 'department_1', 'departmentType' => 'BASIC', 'formationDate' => '2002-12-20',
          'faculty' => { 'name' => 'faculty_1', 'formationDate' => '2002-12-20' } }
                                                        ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortedDepartments($sort: [SortInput!]){
          departments(sort: $sort){
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

      let(:variables) {
        { "sort" => [{
            "key": 'name',
            "direction": 'DESC'
                     }]}}

      it 'returns departments in correct order' do
        expect(result.dig('data', 'departments').pluck('name')).to eq(%w[department_4 department_3 department_2 department_1])
      end
    end

    describe 'combination' do
      let(:query) { <<~GQL }
        query allDepartments($sort: [SortInput!], $filter:[FilterInput!]){
          departments(sort: $sort, filter: $filter){
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

      let(:variables) {
        { "filter" => [{
          "key":'name',
          "filter": '1'
                       },
                       {
          "key":'name',
          "filter": '4'
                       }],
          "sort" => [{
          "key": 'name',
          "direction": 'DESC'
                     }]}}

      it 'returns filtered departments in correct order' do
        expect(result.dig('data', 'departments').pluck('name')).to eq(%w[department_4 department_1])
      end
    end
  end
end
