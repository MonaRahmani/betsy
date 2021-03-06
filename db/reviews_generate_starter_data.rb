require "faker"
require "date"
require "csv"

# to run: ruby db/reviews_generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/reviews_seeds.csv", "w", :write_headers => true,
         :headers => ["rating", "review_content", "name", "product_id"]) do |csv|

  50.times do
    rating = rand(1..5)
    review_content = ""
    name = Faker::Name.name # name of the reviewer
    product_id = ""

    csv << [rating, review_content, name, product_id]
  end
end
