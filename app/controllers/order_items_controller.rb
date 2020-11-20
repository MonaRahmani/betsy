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

    if @cart.add_product(product, quantity)
      redirect_to cart_path

    else
      flash[:error] = 'There was a problem adding this item to your cart.'
      redirect_to product_path(product)
    end
  end


  private
  def order_params
    return params.require(:order_item).permit(:quantity)
  end

end
