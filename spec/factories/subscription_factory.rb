FactoryBot.define do
  factory :subscription do
    title { Faker::WorldCup.team + " Teas"}
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2)}
  end
end