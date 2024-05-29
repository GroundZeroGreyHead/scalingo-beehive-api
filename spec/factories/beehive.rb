FactoryBot.define do
  factory :beehive do
    name { Faker::Lorem.characters(number: 8) }
    weight { Faker::Number.between(from: 1.0, to: 50.0) }
  end
end