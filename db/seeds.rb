# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all if Rails.env.development?
Company.destroy_all if Rails.env.development?
Group.destroy_all if Rails.env.development?
Companies_Pointer.destroy_all if Rails.env.development?

puts "creating sample..."

User.create(name: "Alexander", email: "test@gmail.com", password: "123123")
User.create(name: "Helen", email: "troy@gmail.com", password: "123123")

#bigger companies
Company.create(ticker: "AAPL")
Company.create(ticker: "GOOG")
Company.create(ticker: "AMZN")
Company.create(ticker: "TSLA")
Company.create(ticker: "UBER")
Company.create(ticker: "MSFT")
Company.create(ticker: "NFLX")

#smaller companies
Company.create(ticker: "LL")
Company.create(ticker: "SWI")
Company.create(ticker: "BWLD")

#indexes
Company.create(ticker: ".DJI")
Company.create(ticker: ".INX")
Company.create(ticker: "NYA")

4.times do
  Group.create(user: rand.(1..2))
end

13.times do
  Companies_Pointer.create(group_id: rand(1..4), company_id: rand(1..13))
end

puts. "created sample"
