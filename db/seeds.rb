# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MarketIndex.destroy_all if Rails.env.development?
User.destroy_all if Rails.env.development?
Company.destroy_all if Rails.env.development?
Group.destroy_all if Rails.env.development?
CompaniesPointer.destroy_all if Rails.env.development?

puts "creating sample..."

alexander = User.create!(name: "Alexander", email: "test@gmail.com", password: "123123")
helen = User.create!(name: "Helen", email: "troy@gmail.com", password: "123123")
user_array = [alexander, helen]
name_array = ["tech", "s&p500", "it", "my personal shit"]
#bigger companies
APPL = Company.create!(ticker: "AAPL")
GOOG = Company.create!(ticker: "GOOG")
AMZN = Company.create!(ticker: "AMZN")
TSLA = Company.create!(ticker: "TSLA")
UBER = Company.create!(ticker: "UBER")
MSFT = Company.create!(ticker: "MSFT")
NFLX = Company.create!(ticker: "NFLX")

#smaller companies
LL = Company.create!(ticker: "LL")
SWI = Company.create!(ticker: "SWI")
BWLD = Company.create!(ticker: "BWLD")

#indexes
DJI = Company.create!(ticker: ".DJI")
INX = Company.create!(ticker: ".INX")
NYA = Company.create!(ticker: "NYA")

company = [APPL, GOOG, AMZN, TSLA, UBER, MSFT, NFLX, LL, SWI, BWLD, DJI, INX, NYA]

group = []
4.times do
  group << Group.create!(user: user_array.sample, name: name_array.sample)
end

13.times do
  CompaniesPointer.create!(group: group.sample, company: company.sample)
end

MarketIndex.create!(name: "S&P 500 Index", ticker: ".INX")
# MarketIndex.create!(name: "NASDAQ", ticker: ".IXIC") --> the ticker is not working #Sean
MarketIndex.create!(name: "DOW JONES", ticker: ".DJI")
MarketIndex.create!(name: "Russell 2000", ticker: "^RUT")
puts "created sample"
