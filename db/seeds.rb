require 'csv'

USER_FILE = Rails.root.join('db', 'users_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  user.email = row['email']

  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


ORDER_FILE = Rails.root.join('db', 'orders_seeds.csv')
puts "Loading raw order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.email = row['email']
  order.street_address = row['street_address']
  order.city = row['city']
  order.state = row['state']
  order.zip_code = row['zip_code']
  order.credit_card_name = row['credit_card_name']
  order.credit_card_num = row['credit_card_num']
  order.cvv_num = row['cvv_num']
  order.status = row['status']
  order.cc_exp_month = row['cc_exp_month'].to_i
  order.cc_exp_year = row['cc_exp_year'].to_i

  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} orders failed to save"


CATEGORY_FILE = Rails.root.join('db', 'categories_seeds.csv')
puts "Loading raw category data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.category_name = row['category_name']
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"


PRODUCT_FILE = Rails.root.join('db', 'products_seeds.csv')
puts "Loading raw product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.name = row['name']
  product.description = row['description']
  product.price = row['price'].to_f
  product.photo_url = row['photo_url']
  product.stock = row['stock'].to_i
  product.user_id = User.find_by(username: row['username']).id
  product.retired = row['retired']
  product.categories << Category.find_by(category_name: row['categories'])
  successful = product.save

  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"

ORDER_ITEM_FILE = Rails.root.join('db', 'order_items_seeds.csv')
puts "Loading raw order_item data from #{ORDER_ITEM_FILE}"

order_item_failures = []
CSV.foreach(ORDER_ITEM_FILE, :headers => true) do |row|
  order_item = OrderItem.new
  order_item.quantity = row['quantity']
  order_item.shipped = row['shipped']
  order_item.product_id = Product.find_by(name: row['name']).id
  order_item.order_id = Order.find_by(credit_card_name: row['credit_card_name']).id
  successful = order_item.save
  if !successful
    order_item_failures << order_item
    puts "Failed to save order_item: #{order_item.inspect}"
  else
    puts "Created order_item: #{order_item.inspect}"
  end
end

puts "Added #{OrderItem.count} order_item records"
puts "#{order_item_failures.length} order_items failed to save"

REVIEW_FILE = Rails.root.join('db', 'categories_seeds.csv')
puts "Loading raw review data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.name = Product.find_by(name: row['name']).id
  review.reviewer_name = row['reviewer_name']
  review.rating = row['rating']
  review.name = row['description']
  successful = review.save
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"