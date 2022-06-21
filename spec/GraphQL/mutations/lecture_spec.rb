# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture mutations' do
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
        "groupId": make_global_id(group),
        "subjectId": make_global_id(subject),
        "lecturerId": make_global_id(lecturer),
        "lectureTimeId": make_global_id(lecture_time),
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
        "group"=>{"id"=>make_global_id(group)}, "subject"=>{"id"=>make_global_id(subject)}, "lecturer"=>{"id"=>make_global_id(lecturer)},
         "lectureTime"=>{"id"=>make_global_id(lecture_time)}}
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
        "lectureId": make_global_id(lecture),
        "groupId": make_global_id(group),
        "subjectId": make_global_id(subject),
        "lecturerId": make_global_id(lecturer),
        "lectureTimeId": make_global_id(lecture_time),
        "corpus": 3,
        "weekday": "TUESDAY",
        "auditorium": 101
      }}}

    it 'updates lecture' do
      expect(lecture.id).to eq(1)
      expect(result.dig('data', 'updateLecture')).to eq(
        {"corpus"=>3, "weekday"=>"TUESDAY", "auditorium"=>101,
        "group"=>{"id"=>make_global_id(group)}, "subject"=>{"id"=>make_global_id(subject)},
        "lecturer"=>{"id"=>make_global_id(lecturer)}, "lectureTime"=>{"id"=>make_global_id(lecture_time)}}
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
        "lectureId": make_global_id(lecture)
      }}}

    it 'deletes lecture' do
      expect{ result }.to change { Lecture.count }.by(-1)
    end

    it 'deletes correct lecture' do
      expect(result.dig('data', 'deleteLecture')).to eq(
        "auditorium"=>1, "corpus"=>1, "group"=>{"id"=>make_global_id(lecture.group)},
        "lectureTime"=>{"id"=>make_global_id(lecture.lecture_time)}, "lecturer"=>{"id"=>make_global_id(lecture.lecturer)},
        "subject"=>{"id"=>make_global_id(lecture.subject)}, "weekday"=>"TUESDAY"
                                                     )
    end
  end
end
