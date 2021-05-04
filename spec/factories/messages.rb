FactoryBot.define do
  factory :message do
    message     { Faker::Lorem.sentence }
    association :user
    association :room
  end
end
