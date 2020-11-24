class Order < ApplicationRecord
  has_many :order_items

  #validation status:string

  # method to set default values before saving
  after_initialize :init

  def init
    self.status ||= "paid"          #will set the default value only if it's nil
  end

  def add_product(product, quantity)
    current_item = OrderItem.find_by(product_id: product.id, order_id: self.id )

    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      new_item = OrderItem.new(product_id: product.id,
                               quantity: quantity,
                                  order_id: self.id)
      new_item.save
    end
  end

  def display_items
    current_items = {}
    self.order_items.each do |item|
      product = Product.find_by(id: item["product_id"])
      current_items[product] = item["quantity"]
    end
    return current_items
  end

  def total
    total = 0
    self.order_items.each do |item|
      total += item.order_item_subtotal
    end
    return total
  end
end

