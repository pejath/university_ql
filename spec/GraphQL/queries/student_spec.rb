# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

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
        {'id'=>'1', 'name'=>'Robert', 'group'=>{'id'=>'1'}}, 
        {'id'=>'2', 'name'=>'Robert', 'group'=>{'id'=>'2'}}
                                                    ])
    end
  end

  describe '#student(id)' do
    let!(:student) { create(:student, name: 'Jason') }
    let(:query) { <<~GQL }
      query Student($id: ID!){
        student(id: $id){
          id,
          name,
          group{
            id
          }
        }
      }
    GQL

    let(:variables) {{"id": "1"}}

    it 'returns one student' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'student')).to eq(
        {'id'=>'1', 'name'=>'Jason', 'group'=>{'id'=>'1'}}
                                               )
    end
  end
end
