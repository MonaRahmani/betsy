class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # belongs_to :user, through: :product

  validates :quantity, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  def order_item_subtotal
    self.quantity * self.product.price
  end
end
