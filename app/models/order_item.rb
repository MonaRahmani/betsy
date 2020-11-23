class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  def order_item_subtotal
    return self.quantity * self.product.price
  end
end
