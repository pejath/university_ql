# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Faculty queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#faculties' do
    let!(:faculty1) { FactoryBot.create(:faculty) }
    let!(:faculty2) { FactoryBot.create(:faculty) }
    let!(:faculty3) { FactoryBot.create(:faculty) }
    let!(:faculty4) { FactoryBot.create(:faculty) }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredFaculties($filter: [FilterInput!]){
          faculties(filter: $filter){
            id,
            name,
            formationDate
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key": 'name',
          "filter": '1'
                       }]}}

      it 'returns all faculties' do
        data = result.dig('data', 'faculties')
        expect(data.count).to eq(1)
      end

      it 'returns correct data' do
        expect(result.dig('data', 'faculties')).to eq([
          { 'id' => make_global_id(faculty1), 'name' => 'faculty_1', 'formationDate' => '2002-12-20' },
                                                      ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortedFaculties($sort: [SortInput!]){
          faculties(sort: $sort){
            id,
            name,
            formationDate
          }
        }
      GQL

      let(:variables) {
        { "sort" => [{
          "key": 'name',
          "direction": 'DESC'
                     }]}}

      it 'returns faculties in correct order' do
        expect(result.dig('data', 'faculties').pluck('name')).to eq(%w[faculty_4 faculty_3 faculty_2 faculty_1])
      end
    end

    describe 'combination' do
      let(:query) { <<~GQL }
        query allFaculties($sort: [SortInput!], $filter:[FilterInput!]){
          faculties(sort: $sort, filter: $filter){
            id,
            name,
            formationDate
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

      it 'returns filtered faculties in correct order' do
        expect(result.dig('data', 'faculties').pluck('name')).to eq(%w[faculty_4 faculty_1])
      end
    end
  end

end
