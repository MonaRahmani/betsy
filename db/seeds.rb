require 'csv'

# commented out below is seeds.rb from media ranker, can be used as a template.
#
# WORK_FILE = Rails.root.join('db', 'works_seeds.csv')
# puts "Loading raw work data from #{WORK_FILE}"
#
# work_failures = []
# CSV.foreach(WORK_FILE, :headers => true) do |row|
#   work = Work.new
#   work.category = row['category']
#   work.title = row['title']
#   work.creator = row['creator']
#   work.publication_year = row['publication_year'].to_i
#   work.description = row['description']
#   successful = work.save
#   if !successful
#     work_failures << work
#     puts "Failed to save work: #{work.inspect}"
#   else
#     puts "Created work: #{work.inspect}"
#   end
# end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"



USER_FILE = Rails.root.join('db', 'users_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  user.email = row['title']
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


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"