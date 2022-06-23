# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecturer queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lecturers' do
    let!(:lecturer) { FactoryBot.create_list(:lecturer, 2, name: 'Jason Padberg') }
    let(:query) { <<~GQL }
      query allLecturers{
        lecturers{
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

    it 'returns all lecturers' do
      data = result.dig('data', 'lecturers')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lecturers')).to eq([
        {'id'=>make_global_id(lecturer[0]), 'name'=>'Jason Padberg', 'academicDegree'=>1,
         'department'=>{'id'=>make_global_id(lecturer[0].department), 'name'=>'department_1', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}},

        {'id'=>make_global_id(lecturer[1]), 'name'=>'Jason Padberg', 'academicDegree'=>1,
         'department'=>{'id'=>make_global_id(lecturer[1].department), 'name'=>'department_2', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}}
                                                    ])
    end
  end

  describe '#lecturer(id)' do
    let!(:lecturer) { create(:lecturer, name: 'Jason Padberg') }
    let(:query) { <<~GQL }
      query Lecturer($id: ID!){
        node(id: $id){
          ... on Lecturer{
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
      }
    GQL

    let(:variables) {{"id": make_global_id(lecturer)}}

    it 'returns one lecturer' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        {'id'=>make_global_id(lecturer), 'name'=>'Jason Padberg', 'academicDegree'=>1,
        'department'=>{'id'=>make_global_id(lecturer.department), 'name'=>'department_1', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}}
                                                )
    end
  end
end
