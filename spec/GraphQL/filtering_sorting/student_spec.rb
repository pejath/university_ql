# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#students' do
    let!(:student1) { FactoryBot.create(:student, name: 'a') }
    let!(:student2) { FactoryBot.create(:student, name: 'b') }
    let!(:student3) { FactoryBot.create(:student, name: 'c') }
    let!(:student4) { FactoryBot.create(:student, name: 'd') }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredStudents($filter: [FilterInput!]){
          students(filter: $filter){
            id,
            name,
            group{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key": 'name',
          "filter": 'c'
        }]}}

      it 'returns one students' do
        data = result.dig('data', 'students')
        expect(data.count).to eq(1)
      end

      it 'returns correct student' do
        expect(result.dig('data', 'students')).to eq([
          {'id'=>make_global_id(student3), 'name'=>'c', 'group'=>{'id'=>make_global_id(student3.group)}}
                                                      ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortedStudents($sort: [SortInput!]){
          students(sort: $sort){
            id,
            name,
            group{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "sort" => [{
          "key": 'name',
          "direction": 'DESC'
        }]}}

      it 'returns students in correct order' do
        expect(result.dig('data', 'students').pluck('name')).to eq(%w[d c b a])
      end
    end

    describe 'combination' do
      let(:query) { <<~GQL }
        query allStudents($sort: [SortInput!], $filter:[FilterInput!]){
          students(sort: $sort, filter: $filter){
            id,
            name,
            group{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key":'name',
          "filter": 'd'
                       },
                       {
          "key":'name',
          "filter": 'a'
                       }],
          "sort" => [{
          "key": 'name',
          "direction": 'DESC'
                     }]}}

      it 'returns filtered students in correct order' do
        expect(result.dig('data', 'students').pluck('name')).to eq(%w[d a])
      end
    end
  end
end
