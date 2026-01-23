FactoryBot.define do
  factory :enrollment do
    association :user
    association :event
  end
end
