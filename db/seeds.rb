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