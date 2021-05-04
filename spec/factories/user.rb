FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 4) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    age                   { Faker::Number.between(from: 20, to: 120) }
    gender_id             { Faker::Number.between(from: 1, to: 3) }
    country_id            { Faker::Number.between(from: 1, to: 2) }
  end
end