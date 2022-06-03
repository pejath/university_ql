FactoryBot.define do

  factory :student do

    trait :with_red_diploma do
      association :group, factory: :group, course: 5
      after(:create) do |student|
        FactoryBot.create(:mark, mark: 5, student: student)
      end
    end

    association :group, factory: :group
    name { Faker::Name.name }

  end

  factory :invalid_student, class: Student do
    name { nil }
  end
end

