# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Group queries' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) { {} }

  describe '#groups' do
    let!(:group1) { FactoryBot.create(:group, course: 2) }
    let!(:group2) { FactoryBot.create(:group) }
    let!(:group3) { FactoryBot.create(:group) }
    let!(:group4) { FactoryBot.create(:group) }

    describe 'filtering' do
      let(:query) { <<~GQL }
        query filteredGroups($filter: [FilterInput!]){
          groups(filter: $filter){
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

      let(:variables) {
        { "filter" => [{
          "key": 'specialization_code',
          "filter": '1'
        }]}}

      it 'returns one groups' do
        data = result.dig('data', 'groups')
        expect(data.count).to eq(1)
      end

      it 'returns correct data' do
        expect(result.dig('data', 'groups')).to eq([
          {'id'=>make_global_id(group1), 'course'=>2, 'formOfEducation'=>'EVENING', 'specializationCode'=>1,
           'curator'=>{'id'=>make_global_id(group1.curator), 'name'=>group1.curator.name, 'academicDegree'=>1},
           'department'=>{'id'=>make_global_id(group1.department), 'name'=>'department_2', 'departmentType'=>'BASIC', 'formationDate'=>'2002-12-20'}}]
                                                  )
      end
    end

    describe 'sorting' do
      let(:query) { <<~GQL }
        query sortedGroups($sort: [SortInput!]){
          groups(sort: $sort){
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

      let(:variables) {
        { "sort" => [{
            "key": 'specialization_code',
            "direction": 'DESC'
                     }]}}

      it 'returns groups in correct order' do
        expect(result.dig('data', 'groups').pluck('specializationCode')).to eq([4, 3, 2, 1])
      end

      describe 'combination' do
        let(:query) { <<~GQL }
          query allGroups($sort: [SortInput!], $filter:[FilterInput!]){
            groups(sort: $sort, filter: $filter){
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

        let(:variables) {
          { "filter" => [{
            "key":'specialization_code',
            "filter": '1'
                         },
                         {
            "key":'specialization_code',
            "filter": '3'
                         }],
            "sort" => [{
            "key": 'specialization_code',
            "direction": 'DESC'
                       }]}}

        it 'returns filtered groups in correct order' do
          expect(result.dig('data', 'groups').pluck('specializationCode')).to eq([3, 1])
        end
      end
    end
  end
end
