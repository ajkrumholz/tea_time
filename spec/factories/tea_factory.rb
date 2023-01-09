FactoryBot.define do
  factory :tea do
    title { Faker::Coffee.blend_name}
    description { Faker::Coffee.notes }
    temperature { Faker::Number.between(from: 100, to: 200) }
    brew_time { Faker::Number.between(from: 180, to: 600) }
  end
end