# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Group queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#groups' do
    let!(:group1) { FactoryBot.create(:group, course: 2, curator: create(:lecturer, name: 'Jason Padberg')) }
    let!(:group2) { FactoryBot.create(:group, course: 2, curator: create(:lecturer, name: 'Jason Padberg')) }
    let(:query) { <<~GQL }
      query allGroups{
        groups{
          id,
          course,
          formOfEducation,
          specializationCode,
          curator{
            id,
            name,
            academicDegree
          }
          department{
            id,
            name,
            departmentType,
            formationDate
          }
        }
      }
    GQL

    it 'returns all groups' do
      data = result.dig('data', 'groups')
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'groups')).to eq([
        {'id'=>'1', 'course'=>2, 'formOfEducation'=>0, 'specializationCode'=>1,
         'curator'=>{'id'=>'1', 'name'=>'Jason Padberg', 'academicDegree'=>1},
         'department'=>{'id'=>'2', 'name'=>'department_2', 'departmentType'=>0, 'formationDate'=>'2002-12-20'}},

        {'id'=>'2', 'course'=>2, 'formOfEducation'=>0, 'specializationCode'=>2,
         'curator'=>{'id'=>'2', 'name'=>'Jason Padberg', 'academicDegree'=>1},
         'department'=>{'id'=>'4', 'name'=>'department_4', 'departmentType'=>0, 'formationDate'=>'2002-12-20'}}])
    end
  end

  describe '#group(id)' do
    let!(:group) { create(:group, course: 2, curator: create(:lecturer, name: 'Jason Padberg')) }
    let(:query) { <<~GQL }
      query group{
        group(id: 1){
          id,
          course,
          formOfEducation,
          specializationCode,
          curator{
            id,
            name,
            academicDegree
          }
          department{
            id,
            name,
            departmentType,
            formationDate
          }
        }
      }
    GQL

    it 'returns one group' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'group')).to eq(
        {'id'=>'1', 'course'=>2, 'formOfEducation'=>0, 'specializationCode'=>1,
         'curator'=>{'id'=>'1', 'name'=>'Jason Padberg', 'academicDegree'=>1},
         'department'=>{'id'=>'2', 'name'=>'department_2', 'departmentType'=>0, 'formationDate'=>'2002-12-20'}}
                                             )
    end
  end
end
