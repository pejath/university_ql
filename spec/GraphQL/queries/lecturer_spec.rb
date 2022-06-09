# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecturer queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#lecturers' do
    let!(:lecturer) { FactoryBot.create_list(:lecturer, 2, name: 'Jason Padberg') }
    let(:query) { <<~GQL }
      query allLecturers{
        lecturers{
          id,
          name,
          academicDegree,
          department{
            id,
            name,
            departmentType,
            formationDate
          }
        }
      }
    GQL

    it 'returns all lecturers' do
      data = result.dig('data', 'lecturers')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lecturers')).to eq([
        {'id'=>'1', 'name'=>'Jason Padberg', 'academicDegree'=>1,
         'department'=>{'id'=>'1', 'name'=>'department_1', 'departmentType'=>'Basic', 'formationDate'=>'2002-12-20'}},

        {'id'=>'2', 'name'=>'Jason Padberg', 'academicDegree'=>1,
         'department'=>{'id'=>'2', 'name'=>'department_2', 'departmentType'=>'Basic', 'formationDate'=>'2002-12-20'}}
                                                    ])
    end
  end

  describe '#lecturer(id)' do
    let!(:lecturer) { create(:lecturer, name: 'Jason Padberg') }
    let(:query) { <<~GQL }
      query Lecturer{
        lecturer(id: 1){
          id,
          name,
          academicDegree,
          department{
            id,
            name,
            departmentType,
            formationDate
          }
        }
      }
    GQL

    it 'returns one lecturer' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lecturer')).to eq(
        {'id'=>'1', 'name'=>'Jason Padberg', 'academicDegree'=>1,
        'department'=>{'id'=>'1', 'name'=>'department_1', 'departmentType'=>'Basic', 'formationDate'=>'2002-12-20'}}
                                                )
    end
  end
end
