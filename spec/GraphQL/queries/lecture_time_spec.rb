# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture time query' do
  subject(:result) { execute_query(query, variables: variables) }
  let(:variables) {{}}

  describe '#lecture_time' do
    let!(:lecture_times) { FactoryBot.create_pair(:lecture_time) }
    let(:query) { <<~GQL }
      query lectureTime{
        lectureTime{
          id,
          beginning
        }
      }
    GQL

    it 'returns all lecture time' do
      data = result.dig('data', 'lectureTime')
      puts data
      expect(data.count).to eq(2)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'lectureTime')).to eq([
        {'id'=>'1', 'beginning'=> lecture_times[0][:beginning].time.to_s},
        {'id'=>'2', 'beginning'=> lecture_times[1][:beginning].time.to_s}
                                                      ])
    end
  end
end

