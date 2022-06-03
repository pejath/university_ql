FactoryBot.define do

  factory :faculty do
    sequence(:name) { |n| "faculty_#{n}" }
    formation_date { '20.12.2002' }
  end

  factory :invalid_faculty, class: Faculty do
    name { nil }
  end
end

