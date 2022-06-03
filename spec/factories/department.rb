FactoryBot.define do

  factory :department do
    association :faculty, factory: :faculty

    sequence(:name) { |n| "department_#{n}" }
    formation_date { '20.12.2002' }
    department_type { 'Basic' }
  end

  factory :invalid_department, class: Department do
    name { nil }
  end
end

