class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :order_items #i think this will let us figure out the logic to retire a product
  # has_and_belongs_to_many :categories
end
