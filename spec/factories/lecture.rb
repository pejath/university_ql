FactoryBot.define do

  factory :lecture do
    association :lecture_time, factory: :lecture_time
    association :group, factory: :group
    association :lecturer, factory: :lecturer
    association :subject, factory: :subject

    weekday { %w[Monday Tuesday Wednesday Thursday Friday Saturday].sample  }
    sequence(:corpus) { |n| n }
    sequence(:auditorium) { |n| n }
  end

  factory :invalid_lecture, class: Lecture do
    auditorium { nil }
  end
end

