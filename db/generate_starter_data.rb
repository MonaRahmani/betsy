require "faker"
require "date"
require "csv"

# to run: ruby db/generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other


CSV.open("db/products_seeds.csv", "w", :write_headers => true,
         :headers => ["name", "description", "price", "photo_url", "stock", "retired"]) do |csv|
  20.times do
    name = ""
    description = Faker::Quote.yoda
    price = 0
    photo_url = "https://i.pinimg.com/564x/a9/f3/b1/a9f3b1e3aef96d52fca5e01d3fb22434.jpg"
    stock = 0
    retired = true

    csv << [name, description, price, photo_url, stock, retired]
  end
end
#
# CSV.open("db/users_seeds.csv", "w", :write_headers => true,
#          :headers => ["username", "email"]) do |csv|
#   25.times do
#     username = Faker::Name.name
#     email = username.split(" ").join.downcase + "@dream-team.com"
#
#     csv << [username, email]
#   end
# end
