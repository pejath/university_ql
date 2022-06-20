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

    it 'returns all lectures' do
      data = result.dig('data', 'lectures')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do

      expect(result.dig('data', 'lectures')).to eq([
        {'id' => make_global_id(lectures[0]),'weekday' => 'SATURDAY', 'corpus' => 1, 'auditorium' => 1,
         'lectureTime' => {'id' => make_global_id(lectures[0].lecture_time)},
         'group' => {'id' => make_global_id(lectures[0].group)},
         'lecturer' => {'id' => make_global_id(lectures[0].lecturer)},
         'subject' => {'id' => make_global_id(lectures[0].subject)}},

        {'id' => make_global_id(lectures[1]),'weekday' => 'SATURDAY', 'corpus' => 2, 'auditorium' => 2,
         'lectureTime' => {'id' => make_global_id(lectures[1].lecture_time)},
         'group' => {'id' => make_global_id(lectures[1].group)},
         'lecturer' => {'id' => make_global_id(lectures[1].lecturer)},
         'subject' => {'id' => make_global_id(lectures[1].subject)}}
                                                   ])
    end
  end

  describe '#lecture(id)' do
    let!(:lecture) { create(:lecture, weekday: 'Monday') }
    let(:query) { <<~GQL }
      query Lecture($id: ID!){
        node(id: $id){
           ... on Lecture{
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
        }
    GQL

    let(:variables) {{"id": make_global_id(lecture)}}

    it 'returns one lecture' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        {'id' => make_global_id(lecture),'weekday' => 'MONDAY', 'corpus' => 1, 'auditorium' => 1,
         'lectureTime' => {'id' => make_global_id(lecture.lecture_time) },
         'group' => {'id' => make_global_id(lecture.group) },
         'lecturer' => {'id' => make_global_id(lecture.lecturer) },
         'subject' => {'id' => make_global_id(lecture.subject) } }
                                               )
    end
  end
end
