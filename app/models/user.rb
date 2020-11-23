class User < ApplicationRecord
  has_many :products
  has_many :order_items, through: :products
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # validates :uid, presence: true, uniqueness: true

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
  # Total Revenue by status:  ("pending", "paid", "complete", "cancelled")
  def total_rev_filtered(status)
    sum = 0
    self.order_items.each do |item|
      if status.nil?
        sum += item.order_item_subtotal
      elsif item.order.status == status
        sum += item.order_item_subtotal
      end
      return sum
    end
  end

  # Total number of orders filtered by status
  def total_orders_filtered(status)
    if status.nil?
      return self.order_items.order.count
    elsif order_items.order.status == status
      return self.order_items.order.count
    end
  end
end