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
      if status.nil? || item.order.status == status
        sum += item.order_item_subtotal

      end
    end
    return sum
  end
  # Total number of orders filtered by status
  # def total_orders_filtered(status)
  #   if status.nil?
  #     return self.order_items.count
  #   elsif
  #
  #       if order_item.order.status == status
  #         count += 1
  #       end
  #   end
  #   end
  # end

  def total_orders_by_status(status)
    status_sort_hash = Hash.new(0)
    if status.nil?
      return self.order_items.count
    else
      self.order_items.each do |order_item|
        if order_item.order.status == status
          status_sort_hash[order_item.order.id] = status
        end
      end
      return status_sort_hash.values.count(status)
    end
  end

  def list_purchases
    Order.where(credit_card_name: self.username)
  end

  def sorted_products
    self.products.sort_by { |product| product.retired.to_s } # f(for false) comes after t(for true)
  end
end