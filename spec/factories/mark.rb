FactoryBot.define do

  factory :mark do
    association :student, factory: :student
    association :subject, factory: :subject
    association :lecturer, factory: :lecturer

    mark { rand(1..5) }
  end

end

