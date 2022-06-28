# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecturer queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lecturers' do
    let!(:lecturer1) { FactoryBot.create(:lecturer, name: 'a') }
    let!(:lecturer2) { FactoryBot.create(:lecturer, name: 'b') }
    let!(:lecturer3) { FactoryBot.create(:lecturer, name: 'd') }
    let!(:lecturer4) { FactoryBot.create(:lecturer, name: 'c') }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredLecturers($filter: [FilterInput!]){
          lecturers(filter: $filter){
            id,
            name,
            academicDegree,
            department{
              id,
              name,
              departmentType,
              formationDate
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key": 'name',
          "filter": 'c'
        }]}}

      it 'returns one lecturers' do
        data = result.dig('data', 'lecturers')
        expect(data.count).to eq(1)
      end

      it 'returns correct lecturer' do
        expect(result.dig('data', 'lecturers')).to eq([
          {'id'=>make_global_id(lecturer4), 'name'=>'c', 'academicDegree'=>1,
           'department'=>{'id'=>make_global_id(lecturer4.department), 'name'=>'department_4', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}}
                                                      ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortingLecturers($sort: [SortInput!]){
          lecturers(sort: $sort){
            id,
            name,
            academicDegree,
            department{
              id,
              name,
              departmentType,
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

      it 'returns lecturers in correct order' do
        expect(result.dig('data', 'lecturers').pluck('name')).to eq(%w[d c b a])
      end
    end

    describe 'combiantion' do
      let(:query) { <<~GQL }
        query allLecturers($sort: [SortInput!], $filter:[FilterInput!]){
          lecturers(sort: $sort, filter: $filter){
            id,
            name,
            academicDegree,
            department{
              id,
              name,
              departmentType,
              formationDate
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key":'name',
          "filter": 'c'
                       },
                       {
          "key":'name',
          "filter": 'b'
                       }],
          "sort" => [{
          "key": 'name',
          "direction": 'DESC'
                     }]}}

      it 'returns filtered lecturers in correct order' do
        expect(result.dig('data', 'lecturers').pluck('name')).to eq(%w[c b])
      end
    end
  end
end
