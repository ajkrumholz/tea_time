FactoryBot.define do
  factory :tea do
    title { Faker::Coffee.blend_name}
    description { Faker::Coffee.notes }
    temperature { Faker::Number.within(from: 100, to: 200) }
    brew_time { Faker::Number.within(from: 180, to: 600) }
  end
end