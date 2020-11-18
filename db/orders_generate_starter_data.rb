require "faker"
require "date"
require "csv"

# to run: ruby db/orders_generate_starter_data.rb
# review orders_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/orders_seeds.csv", "w", :write_headers => true,
         :headers => ["street_address", "city", "state", "zip_code", "credit_card_name", "credit_card_num", "email", "cc_exp_month", "cc_exp_year", "cvv_num", "status"]) do |csv|
  20.times do

    street_address = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip_code = Faker::Address.zip
    credit_card_name = Faker::Name.unique.name # note, this doesnt pull from user csv
    credit_card_num = Faker::Finance.credit_card(:mastercard)
    email = "#{credit_card_name.split(" ").join.downcase}@dream-team.com"
    cc_exp_month = rand(1..12)
    cc_exp_year = rand(2021..2026)
    cvv_num = rand(100..999).to_s
    status = ["pending", "paid", "complete", "cancelled"].sample

    csv << [ street_address, city, state, zip_code, credit_card_name, credit_card_num, email, cc_exp_month, cc_exp_year, cvv_num, status ]
  end
end