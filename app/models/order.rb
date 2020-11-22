class Order < ApplicationRecord
  has_many :order_items
  #validation status:string


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

  def total
    return @order_items.order_item_subtotal
  end
end
