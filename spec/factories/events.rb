# spec/factories/events.rb
FactoryBot.define do
  factory :event do
    association :user, factory: :user
    title { "Test Event" }
    category { :other }
    starts_at { 1.day.from_now }
    allowed_gender { :any }
    rsvp { :public_event }
    min_age { nil }
    max_age { nil }
    max_capacity { 10 }

    trait :full_capacity do
      max_capacity { 1 }
    end
  end
end
