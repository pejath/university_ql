# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Group queries' do
  subject(:result) { QlSchema.execute(query) }

  describe '#createGroup' do
    let!(:lecturer) { create(:lecturer) }
    let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation createGroup {
       createGroup(input:{curatorId: 1, departmentId: 1, course: 2, specializationCode: 223, formOfEducation: Evening}){
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
         }
       }
    GQL

    it 'creates one group' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createGroup')).to eq(
        {'course'=>2, 'formOfEducation'=>'Evening', 'specializationCode'=>223,
        'curator'=>{'id'=>'1'}, 'department'=>{'id'=>'1'}}
                                                   )
    end
  end

  describe '#updateGroup' do
    let!(:group) { create(:group, course: 3) }
    let!(:lecturer) { create(:lecturer) }
    # let!(:department) { create(:department) }
    let(:query) { <<~GQL }
      mutation updateGroup {
       updateGroup(input:{id: 1, curatorId: 2, departmentId: 1, course: 2, specializationCode: 223, formOfEducation: Correspondence}){
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
         }
       }
    GQL

    it 'updates group' do
      expect(group.id).to eq(1)
      expect(group.curator_id).to eq(1)
      expect(group.department_id).to eq(2)
      expect(group.form_of_education).to eq('evening')
      expect(group.specialization_code).to eq(1)
      expect(result.dig('data', 'updateGroup')).to eq(
        {'course'=>2, 'formOfEducation'=>'Correspondence', 'specializationCode'=>223,
        'curator'=>{'id'=>'2'}, 'department'=>{'id'=>'1'}}
                                                     )
    end
  end

  describe '#deleteGroup' do
    let!(:group) { create(:group, course: 1) }
    let(:query) { <<~GQL }
      mutation deleteGroup {
        deleteGroup(input: {id: 1}) {
         id
         course,
         formOfEducation,
         specializationCode,
         curator{ id }
         department{ id }
        }
      }
    GQL

    it 'deletes group' do
      expect{ result }.to change { Group.count }.by(-1)
    end

    it 'deletes correct group' do
      expect(result.dig('data', 'deleteGroup')).to eq(
        { 'id'=>'1','course'=>1, 'formOfEducation'=>'Evening', 'specializationCode'=>1,
        'curator'=>{'id'=>'1'}, 'department'=>{'id'=>'2'} }
                                                     )
    end
  end
end
