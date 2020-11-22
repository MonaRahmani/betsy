require "faker"
require "date"
require "csv"

# to run: ruby db/users_generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/users_seeds.csv", "w", :write_headers => true,
         :headers => ["username", "email", "uid"]) do |csv|
  i = 1
  25.times do
    username = Faker::Name.unique.name
    email = "#{username.split(" ").join.downcase}@dream-team.com"
    uid = i
    csv << [username, email, uid]
    i += 1
  end
end
