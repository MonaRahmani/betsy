class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :order_items #i think this will let us figure out the logic to retire a product
  # has_and_belongs_to_many :categories
  validates :name, presence: { message: "Product name is required" }, uniqueness: { message: "This product is already for sale." }
  validates :description, presence: { message: "Please enter a description." }
  validates :price, numericality: { greater_than: 0, message: "Enter a positive value for price."}
  validates :stock, numericality: { only_integer: true, greater_than: 0, message: "Enter a positive number for stock."}
  # validates :stock, numericality: { greater_than: 0, message: "Stock must be numeric."}
  validates :categories, presence: { message: "Please enter at least one category." }


end
