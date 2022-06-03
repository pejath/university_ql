FactoryBot.define do

  factory :group do
    association :curator, factory: :lecturer
    association :department, factory: :department

    sequence(:specialization_code) { |n| n }
    course { rand(1..5) }
    form_of_education { 'evening' }
  end

  factory :invalid_group, class: Group do
    course { nil }
  end
end

