class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # belongs_to :user, through: :product

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, message: "The quantity must be a positive value."}

  def order_item_subtotal
    self.quantity * self.product.price
  end

  class OrderItem < ApplicationRecord
    belongs_to :product
    belongs_to :order

    validates :quantity, presence: true
    validates :quantity, presence: true, numericality: { only_integer: true }

    def order_item_subtotal
      self.quantity * self.product.price
    end

    def self.display_items(order_items)
      current_items = {}
      order_items.each do |item|
        product = Product.find_by(id: item["product_id"])
        current_items[product] = item["quantity"]
      end
      return current_items
    end
    
  end
end
