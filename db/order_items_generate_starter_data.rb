require "faker"
require "date"
require "csv"

# to run: ruby db/order_items_generate_starter_data.rb
# review order_items_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/order_items_seeds.csv", "w", :write_headers => true,
         :headers => ["name", "credit_card_name", "quantity", "shipped"]) do |csv|
  20.times do

    name = ""
    credit_card_name = ""
    quantity = rand(1..3)
    shipped = ["true", "false"].sample

    csv << [ name, credit_card_name, quantity, shipped ]
  end
end