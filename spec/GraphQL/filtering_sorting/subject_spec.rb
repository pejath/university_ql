# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subject queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lecturers' do
    let!(:subject1) { FactoryBot.create(:subject, name: 'e') }
    let!(:subject2) { FactoryBot.create(:subject, name: 'f') }
    let!(:subject3) { FactoryBot.create(:subject, name: 'g') }
    let!(:subject4) { FactoryBot.create(:subject, name: 'h') }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredSubjects($filter: [FilterInput!]){
          subjects(filter: $filter){
            id,
            name
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key": 'name',
          "filter": 'g'
        }]}}

      it 'returns one subjects' do
        data = result.dig('data', 'subjects')
        expect(data.count).to eq(1)
      end

      it 'returns correct subject' do
        expect(result.dig('data', 'subjects')).to eq([
          {'id'=>make_global_id(subject3), 'name'=>'g'}
                                                     ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortedSubjects($sort: [SortInput!]){
          subjects(sort: $sort){
            id,
            name
          }
        }
      GQL

      let(:variables) {
        { "sort" => [{
          "key": 'name',
          "direction": 'DESC'
        }]}}

      it 'returns subjects in correct order' do
        expect(result.dig('data', 'subjects').pluck('name')).to eq(%w[h g f e])
      end
    end

    describe 'combination' do
      let(:query) { <<~GQL }
        query allSubjects($sort: [SortInput!], $filter:[FilterInput!]){
          subjects(sort: $sort, filter: $filter){
            id,
            name
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key":'name',
          "filter": 'g'
                       },
                       {
          "key":'name',
          "filter": 'h'
                       },
                       {
          "key":'name',
          "filter": 'e'
                       }],
          "sort" => [{
          "key": 'name',
          "direction": 'DESC'
                     }]}}

      it 'returns filtered subjects in correct order' do
        expect(result.dig('data', 'subjects').pluck('name')).to eq(%w[h g e])
      end
    end
  end
end
