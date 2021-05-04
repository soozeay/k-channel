FactoryBot.define do
  factory :article do
    title       { Faker::Lorem.characters(number: 10) }
    trick       { Faker::Lorem.characters(number: 10) }
    plaza_id    { Faker::Number.between(from: 1, to: 6) }
    youtube_url { "https://www.youtube.com/watch?v=" + Faker::Lorem.characters(number: 11, min_alpha: 11) }
    association :user
    after(:build) do |article|
      article.image.attach(io: File.open('public/images/test_image.png'), filename: 'test.png')
    end
  end
end
