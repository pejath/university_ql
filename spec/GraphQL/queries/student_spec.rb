# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#students' do
    let!(:student) { FactoryBot.create_list(:student, 2, name: 'Robert') }
    let(:query) { <<~GQL }
      query allStudents{
        students{
          id,
          name,
          group{
            id
          }
        }
      }
    GQL

    it 'returns all students' do
      data = result.dig('data', 'students')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'students')).to eq([
        {'id'=>make_global_id(student[0]), 'name'=>'Robert', 'group'=>{'id'=>make_global_id(student[0].group)}},
        {'id'=>make_global_id(student[1]), 'name'=>'Robert', 'group'=>{'id'=>make_global_id(student[1].group)}}
                                                    ])
    end
  end

  describe '#student(id)' do
    let!(:student) { create(:student, name: 'Jason') }
    let(:query) { <<~GQL }
      query Student($id: ID!){
        node(id: $id){
          ... on Student{
            id,
            name,
            group{
              id
            }
          }
        }
      }
    GQL

    let(:variables) {{"id": make_global_id(student)}}

    it 'returns one student' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        {'id'=> make_global_id(student), 'name'=>'Jason', 'group'=>{'id'=> make_global_id(student.group)}}
                                               )
    end
  end
end
