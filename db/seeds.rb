# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


customer = Customer.create!(
  first_name: "A.J.",
  last_name: "Krumholz",
  email: "test@gmail.com",
  address: "123 Socking St."
)

subscription = Subscription.create!(
  title: "Tea for Days",
  price: 54.99
)

CustomerSubscription.create!(
  subscription_id: subscription.id,
  customer_id: customer.id
)

cancelled_sub = Subscription.create!(
  title: "Teas for Now",
  price: 10.99
)

CustomerSubscription.create!(
  subscription_id: cancelled_sub.id,
  customer_id: customer.id,
  status: 'cancelled'
)

Subscription.create!(
  title: "Tea Forever",
  price: 10.99
)

subscription.teas << Tea.create!(
  title: "Mellow Mint",
  description: "Hauntingly minty",
  temperature: 150,
  brew_time: 300
)

subscription.teas << Tea.create!(
  title: "Red Zinger",
  description: "Citric acid + red number five = crazy delicious!",
  temperature: 120,
  brew_time: 500
)
