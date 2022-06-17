# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#createLecture' do
    let!(:group){ create(:group) }
    let!(:subject){ create(:subject) }
    let!(:lecturer){ create(:lecturer) }
    let!(:lecture_time){ create(:lecture_time) }
    let(:query) { <<~GQL }
      mutation createLecture($input: CreateLectureInput!) {
       createLecture(input: $input){
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

    let(:variables) {
      { "input" => {
        "groupId": group.id,
        "subjectId": subject.id,
        "lecturerId": lecturer.id,
        "lectureTimeId": lecture_time.id,
        "corpus": 2,
        "weekday": "MONDAY",
        "auditorium": 100
      }}}

    it 'creates one lecture' do
      expect { result }.to(change(Lecture, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createLecture')).to eq(
        {"corpus"=>2, "weekday"=>"MONDAY", "auditorium"=>100,
        "group"=>{"id"=>group.id.to_s}, "subject"=>{"id"=>subject.id.to_s}, "lecturer"=>{"id"=>lecturer.id.to_s}, "lectureTime"=>{"id"=>lecture_time.id.to_s}}
                                                     )
    end
  end

  describe '#updateLecture' do
    let!(:lecture) { create(:lecture) }
    let(:group) { create(:group) }
    let(:subject) { create(:subject) }
    let(:lecturer) { create(:lecturer) }
    let(:lecture_time) { create(:lecture_time) }
    let(:query) { <<~GQL }
      mutation updateLecture($input: UpdateLectureInput!) {
       updateLecture(input: $input){
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

    let(:variables) {
      { "input" => {
        "id": lecture.id,
        "groupId": group.id,
        "subjectId": subject.id,
        "lecturerId": lecturer.id,
        "lectureTimeId": lecture_time.id,
        "corpus": 3,
        "weekday": "TUESDAY",
        "auditorium": 101
      }}}

    it 'updates lecture' do
      expect(lecture.id).to eq(1)
      expect(result.dig('data', 'updateLecture')).to eq(
        {"corpus"=>3, "weekday"=>"TUESDAY", "auditorium"=>101,
        "group"=>{"id"=>group.id.to_s}, "subject"=>{"id"=>subject.id.to_s}, "lecturer"=>{"id"=>lecturer.id.to_s}, "lectureTime"=>{"id"=>lecture_time.id.to_s}}
                                                     )
    end
  end

  describe '#deleteLecture' do
    let!(:lecture) { create(:lecture, weekday: "Tuesday") }
    let(:query) { <<~GQL }
      mutation deleteLecture($input: DeleteLectureInput!) {
        deleteLecture(input: $input) {
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

    let(:variables) {
      { "input" => {
        "id": lecture.id
      }}}

    it 'deletes lecture' do
      expect{ result }.to change { Lecture.count }.by(-1)
    end

    it 'deletes correct lecture' do
      expect(result.dig('data', 'deleteLecture')).to eq(
        "auditorium"=>1, "corpus"=>1, "group"=>{"id"=>"1"},
        "lectureTime"=>{"id"=>"1"}, "lecturer"=>{"id"=>"2"},
        "subject"=>{"id"=>"1"}, "weekday"=>"TUESDAY"
                                                     )
    end
  end
end
