class OrderItemsController < ApplicationController
  before_action :set_cart, only: [:create]

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
      order.add_product(product, quantity)
    else
      order = Order.create(status: :pending)
      order.add_product(product, quantity)
      session[:order_id] = order.id
    end
    redirect_to products_path(product)
    # else
    #   flash[:error] = 'There was a problem adding this item to your cart.'
    #   redirect_to product_path(product)
  end


  private
  def order_params
    return params.require(:order_item).permit(:quantity)
  end

end