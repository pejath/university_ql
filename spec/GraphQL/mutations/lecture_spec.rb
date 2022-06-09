# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#createLecture' do
    let!(:group){ create(:group) }
    let!(:subject){ create(:subject) }
    let!(:lecturer){ create(:lecturer) }
    let!(:lecture_time){ create(:lecture_time) }
    let(:query) { <<~GQL }
      mutation createLecture {
       createLecture(input:{groupId: 1, subjectId: 1, lecturerId: 1, lectureTimeId: 1,
        corpus: 2, weekday: Monday, auditorium: 100}){
         corpus,
         weekday,
         auditorium,
         group{ id },
         subject{ id },
         lecturer{ id },
         lectureTime{ id }
         }
       }
    GQL

    it 'creates one lecture' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createLecture')).to eq(
        {"createLecture"=>{"corpus"=>2, "weekday"=>"Monday", "auditorium"=>100,
        "group"=>{"id"=>"1"}, "subject"=>{"id"=>"1"}, "lecturer"=>{"id"=>"1"}, "lectureTime"=>{"id"=>"1"}}}
                                                     )
    end
  end

  describe '#updateLecture' do
    let!(:lecture) { create(:lecture) }
    let(:query) { <<~GQL }
      mutation updateLecture {
       updateLecture(input:{id: 1, name: "UpdatedLecture", formationDate:"1990-03-21"}){
         id,
         name,
         formationDate,
         }
       }
    GQL

    it 'updates lecture' do
      expect(lecture.id).to eq(1)
      expect(lecture.name).to eq('lecture_1')
      expect(lecture.formation_date.to_s).to eq('2002-12-20')
      expect(result.dig('data', 'updateLecture')).to eq(
                                                       { 'id'=>'1', 'formationDate'=>'1990-03-21', 'name'=>'UpdatedLecture'}
                                                     )
    end
  end

  describe '#deleteLecture' do
    let!(:lecture) { create(:lecture) }
    let(:query) { <<~GQL }
      mutation deleteLecture {
        deleteLecture(input: {id: 1}) {
          id
          name
          formationDate
        }
      }
    GQL

    it 'deletes lecture' do
      expect{ result }.to change { Lecture.count }.by(-1)
    end

    it 'deletes correct lecture' do
      expect(result.dig('data', 'deleteLecture')).to eq(
                                                       { 'id'=>'1', 'formationDate'=>'2002-12-20', 'name'=>'lecture_1'}
                                                     )
    end
  end
end
