require "faker"
require "date"
require "csv"

# to run: ruby db/users_generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/users_seeds.csv", "w", :write_headers => true,
         :headers => ["username", "email"]) do |csv|
  25.times do
    username = Faker::Name.unique.name
    email = "#{username.split(" ").join.downcase}@dream-team.com"

    csv << [username, email]
  end
end