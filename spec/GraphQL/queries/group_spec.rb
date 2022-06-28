# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Group queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

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
        {'id'=>make_global_id(group1), 'course'=>2, 'formOfEducation'=>'EVENING', 'specializationCode'=>1,
         'curator'=>{'id'=>make_global_id(group1.curator), 'name'=>'Jason Padberg', 'academicDegree'=>1},
         'department'=>{'id'=>make_global_id(group1.department), 'name'=>'department_2', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}},

        {'id'=>make_global_id(group2), 'course'=>2, 'formOfEducation'=>'EVENING', 'specializationCode'=>2,
         'curator'=>{'id'=>make_global_id(group2.curator), 'name'=>'Jason Padberg', 'academicDegree'=>1},
         'department'=>{ 'id'=>make_global_id(group2.department), 'name'=>'department_4', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}}])
    end
  end

  describe '#group(id)' do
    let!(:group) { create(:group, course: 2, curator: create(:lecturer, name: 'Jason Padberg')) }
    let(:query) { <<~GQL }
      query group($id: ID!){
        node(id: $id){
        ... on Group{
            id,
            course,
            formOfEducation,
            specializationCode,
            curator{
              name,
              academicDegree
            }
            department{
              name,
              departmentType,
              formationDate
            }
          }
        }
      }
    GQL

    let(:variables) { {"id": make_global_id(group)} }

    it 'returns one group' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'node')).to eq(
        {'id'=>make_global_id(group), 'course'=>2, 'formOfEducation'=>'EVENING', 'specializationCode'=>1,
         'curator'=>{ 'name'=>'Jason Padberg', 'academicDegree'=>1 },
         'department'=>{ 'name'=>'department_2', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20' } }
                                             )
    end
  end
end
