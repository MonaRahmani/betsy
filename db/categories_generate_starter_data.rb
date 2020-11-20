require "faker"
require "date"
require "csv"

# to run: ruby db/categories_generate_starter_data.rb
# review products_seeds.csv file
# recreate the db with: rails db:reset
# note: doesn't currently check for if names are unique against each other

CSV.open("db/categories_seeds.csv", "w", :write_headers => true,
         :headers => ["category_name"]) do |csv|
  3.times do
    category_name = ""

    csv << [category_name]
  end
end
