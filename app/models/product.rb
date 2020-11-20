class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :order_items #i think this will let us figure out the logic to retire a product
  # has_and_belongs_to_many :categories
  validates :name, presence: { message: "Product name is required" }, uniqueness: { message: "This product is already for sale." }
  validates :description, presence: { message: "Please enter a description." }
  validates :price, numericality: { message: "Price must be numeric."}
  validates :stock, numericality: { only_integer: true, message: "Stock must be numeric."}
  # validates :categories, presence: { message: "Please enter at least one category." }


end
