# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Faculty queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#faculties' do
    let!(:faculties) { FactoryBot.create_list(:faculty, 2) }
    let(:query) { <<~GQL }
      query allFaculties{
        faculties{
          id,
          name,
          formationDate
        }
      }
    GQL

    it 'returns all faculties' do
      data = result.dig('data', 'faculties')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'faculties')).to eq([
        { 'id' => '1', 'name' => 'faculty_1', 'formationDate' => '2002-12-20' },
        { 'id' => '2', 'name' => 'faculty_2', 'formationDate' => '2002-12-20' }
                                                    ])
    end
  end

  describe '#faculty(id)' do
    let!(:faculty) { create(:faculty) }
    let(:query) { <<~GQL }
      query faculty($id: ID!){
        faculty(id: $id){
          id,
          name,
          formationDate
        }
      }
    GQL

    let(:variables) {{"id": "1"}}

    it 'returns one faculty' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'faculty')).to eq(
        { 'id' => '1', 'name' => 'faculty_1', 'formationDate' => '2002-12-20' }
                                               )
    end
  end
end
