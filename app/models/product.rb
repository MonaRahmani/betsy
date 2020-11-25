class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :order_items #i think this will let us figure out the logic to retire a product
  has_many :reviews

  validates :name, presence: { message: "Product name is required" }, uniqueness: { message: "This product is already for sale." }
  validates :description, presence: { message: "Please enter a description." }
  validates :price, numericality: { greater_than: 0, message: "Enter a positive number for price."}
  validates :stock, numericality: { only_integer: true, greater_than: 0, message: "Enter a positive number for stock."}
  validates :categories, presence: { message: "Please enter at least one category." }

  def update_stock



  end

  # def update_order_status
  #   if self.status == 'pending'
  #     self.update_attribute(:status, 'paid')
  #   end
  # end


  def self.active_only
    self.where(retired: false)
  end

  def average_rating
    if self.reviews.length == 0
      return 0
    else
      (self.reviews.sum { |review| review.rating.to_i } / self.reviews.length).round(2)
    end
  end

end
