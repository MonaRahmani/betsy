class Order < ApplicationRecord
  has_many :order_items

  def add_product(product_params)
    current_item = OrderItem.find_by(product_id: product_params[:product][:product_id], order_id: self.id )
    if current_item
      current_item.quantity += product_params[:product][:quantity].to_i
      current_item.save
    else
      new_item = OrderItem.create(product_id: product_params[:product][:product_id],
                                   quantity: product_params[:product][:quantity],
                                  order_id: self.id)
    end
    new_item
  end
end
