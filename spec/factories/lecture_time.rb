FactoryBot.define do

  factory :lecture_time do
    beginning { "#{rand(0..23)}:#{rand(0..59)}" }
  end

end

