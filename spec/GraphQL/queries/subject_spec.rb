# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subject queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lecturers' do
    let!(:subject) { FactoryBot.create_list(:subject, 2) }
    let(:query) { <<~GQL }
      query allSubjects{
        subjects{
          id,
          name
        }
      }
    GQL

    it 'returns all subjects' do
      data = result.dig('data', 'subjects')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'subjects')).to eq([
        {'id'=>make_global_id(subject[0]), 'name'=>'subject_1'},
        {'id'=>make_global_id(subject[1]), 'name'=>'subject_2'}
                                                   ])
    end
  end

  describe '#subject(id)' do
    let!(:subject) { create(:subject) }
    let(:query) { <<~GQL }
      query Subject($id: ID!){
        node(id: $id){
          ... on Subject{
            id,
            name
          }
        }
      }
    GQL

    let(:variables) {{"id":  make_global_id(subject)}}

    it 'returns one subject' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        {'id'=>make_global_id(subject), 'name'=>'subject_1'}
                                               )
    end
  end
end
