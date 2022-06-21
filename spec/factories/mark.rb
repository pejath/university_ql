FactoryBot.define do

  factory :mark do
    association :student, factory: :student
    association :subject, factory: :subject
    association :lecturer, factory: :lecturer

    mark { 1 }
  end

end

