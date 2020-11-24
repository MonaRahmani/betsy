require "faker"
require "date"
require "csv"

# to run: ruby db/reviews_generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/reviews_seeds.csv", "w", :write_headers => true,
         :headers => ["name", "reviewer_name", "rating", "review"]) do |csv|

  50.times do
    name = "" # this is the product name
    reviewer_name = Faker::Name.name
    rating = rand(1..5)
    review = ""
    csv << [name, reviewer_name, rating, review]
  end
end
