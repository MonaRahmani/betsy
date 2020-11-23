class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :quantity, numericality: { only_integer: true, greater_than: 0, message: "Quantity must be greater than 0."}

  def order_item_subtotal
    return self.quantity * self.product.price
  end
end
