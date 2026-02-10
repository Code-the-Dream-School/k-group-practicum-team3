FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    first_name { "John" }
    last_name  { "Doe" }
    age { 25 }
    phone { "123-456-7890" }
    bio { "This is a short bio." }
    city { "New York" }
    state { "NY" }
    zip { "10001" }

    trait :with_organizer_role do
      after(:create) { |user| user.add_role(:organizer) }
    end

    trait :with_student_role do
      after(:create) { |user| user.add_role(:student) }
    end
  end
end
