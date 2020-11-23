class OrderItemsController < ApplicationController

  def create
    product_id = params[:product_id]
    product = Product.find_by(id: product_id)

    if product.nil?
      redirect_to cart_path
      flash[:error] = 'There was a problem adding this item to your cart.'
      return
    end

    quantity = order_params[:quantity].to_i

    if session[:order_id]
      order = Order.find_by(id: session[:order_id])
    else
      order = Order.create(status: :pending)
      session[:order_id] = order.id
    end

    if quantity <= 0
      flash[:error] = "Order quantity must be greater than 0"
      redirect_to products_path(product)
    else
      order.add_product(product, quantity)
      flash[:success] = "#{product.name} added to cart!"
      redirect_to products_path(product)
    end
  end


  private
  def order_params
    return params.permit(:quantity)
  end

end