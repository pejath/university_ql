# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lectures' do
    let!(:lectures) { FactoryBot.create_list(:lecture, 2, weekday: 'Saturday') }
    let(:query) { <<~GQL }
        query allLectures{
        lectures{
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

    it 'returns all lectures' do
      data = result.dig('data', 'lectures')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lectures')).to eq([
        {'weekday'=>'SATURDAY', 'corpus'=>1, 'auditorium'=>1, 'lectureTime'=>{'id'=>'1'}, 'group'=>{'id'=>'1'}, 'lecturer'=>{'id'=>'2'}, 'subject'=>{'id'=>'1'}},
        {'weekday'=>'SATURDAY', 'corpus'=>2, 'auditorium'=>2, 'lectureTime'=>{'id'=>'2'}, 'group'=>{'id'=>'2'}, 'lecturer'=>{'id'=>'4'}, 'subject'=>{'id'=>'2'}}
                                                    ])
    end
  end

  describe '#lecture(id)' do
    let!(:lecture) { create(:lecture, weekday: 'Monday') }
    let(:query) { <<~GQL }
      query Lecture($id: ID!){
           lecture(id: $id){
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

    let(:variables) {{"id": "1"}}

    it 'returns one lecture' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lecture')).to eq(
        {'weekday'=>'MONDAY', 'corpus'=>1, 'auditorium'=>1, 'lectureTime'=>{'id'=>'1'}, 'group'=>{'id'=>'1'}, 'lecturer'=>{'id'=>'2'}, 'subject'=>{'id'=>'1'}}
                                               )
    end
  end
end
