class User < ApplicationRecord
  has_many :products
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true


  # build a user from github hash info
  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]

    # Note that the user has not been saved. We'll choose to do the saving outside of this method.(in create)
    return user
  end

  # Total Revenue
  def total_rev
    sum = 0
    # iterate through user products to find particular order item price
    self.products.each do |product|
      product.order_items.each do |item|

      end
    end
  end

  # Total Revenue by status
  def total_rev_status

  end

  # Total number of orders by status
  def total_num_orders_by_status

  end

  # Filter orders displayed by status
  def orders_filtered_by_status

  end

end
