FactoryBot.define do

  factory :subject do
    sequence(:name) { |n| "subject_#{n}" }
  end

  factory :invalid_subject, class: Subject do
    name { nil }
  end
end

