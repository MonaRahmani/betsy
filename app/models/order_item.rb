class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # belongs_to :user, through: :product

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, message: "The quantity must be a positive value."}


  def order_item_subtotal
    self.quantity * self.product.price
  end

  def stock_update
    self.product.stock - self.quantity
  end
end
