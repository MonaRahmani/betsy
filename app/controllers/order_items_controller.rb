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
    if quantity <= 0
      flash[:error] = 'Please enter a quantity greater than 0.'
    else
        if session[:order_id]
          order = Order.find_by(id: session[:order_id])
        else
          order = Order.create()
          session[:order_id] = order.id
        end

      order.add_product(product, quantity)
      flash[:success] = "#{product.name} added to cart!"
    end
      redirect_to products_path(product)
  end


  private
  def order_params
    return params.permit(:quantity)
  end

end