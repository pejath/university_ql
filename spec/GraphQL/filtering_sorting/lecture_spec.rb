# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lectures' do
    let!(:lecture1) { FactoryBot.create(:lecture) }
    let!(:lecture2) { FactoryBot.create(:lecture) }
    let!(:lecture3) { FactoryBot.create(:lecture) }
    let!(:lecture4) { FactoryBot.create(:lecture) }

    describe 'filtering' do
      let(:query) { <<~GQL }
          query filteredLectures($filter: [FilterInput!]){
          lectures(filter: $filter){
            id,
            weekday,
            corpus,
            auditorium,
            lectureTime{
              id
            }
            group{
              id
            }
            lecturer{
              id
            }
            subject{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key": 'corpus',
          "filter": '2'
        }]}}

      it 'returns all lectures' do
        data = result.dig('data', 'lectures')
        expect(data.count).to eq(1)
      end

      it 'returns correct lecture' do

        expect(result.dig('data', 'lectures')).to eq([
          {'id' => make_global_id(lecture2),'weekday' => lecture2.weekday.upcase, 'corpus' => 2, 'auditorium' => 2,
           'lectureTime' => {'id' => make_global_id(lecture2.lecture_time)},
           'group' => {'id' => make_global_id(lecture2.group)},
           'lecturer' => {'id' => make_global_id(lecture2.lecturer)},
           'subject' => {'id' => make_global_id(lecture2.subject)}}
                                                     ])
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
          query sortedLectures($sort: [SortInput!]){
          lectures(sort: $sort){
            id,
            weekday,
            corpus,
            auditorium,
            lectureTime{
              id
            }
            group{
              id
            }
            lecturer{
              id
            }
            subject{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "sort" => [{
            "key": 'auditorium',
            "direction": 'DESC'
          }]}}

      it 'returns lectures in correct order' do
        expect(result.dig('data', 'lectures').pluck('auditorium')).to eq([4, 3, 2, 1])
      end
    end

    describe 'combination' do
      let(:query) { <<~GQL }
          query allLectures($sort: [SortInput!], $filter:[FilterInput!]){
          lectures(sort: $sort, filter: $filter){
            id,
            weekday,
            corpus,
            auditorium,
            lectureTime{
              id
            }
            group{
              id
            }
            lecturer{
              id
            }
            subject{
              id
            }
          }
        }
      GQL

      let(:variables) {
        { "filter" => [{
          "key":'corpus',
          "filter": '1'
                       },
                       {
          "key":'auditorium',
          "filter": '4'
                       }],
          "sort" => [{
          "key": 'corpus',
          "direction": 'DESC'
                     }]}}

      it 'returns filtered lectures in correct order' do
        expect(result.dig('data', 'lectures').pluck('corpus')).to eq([4, 1])
      end
    end
  end
end
