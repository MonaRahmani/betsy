class OrderItemsController < ApplicationController

  def create

    product = Product.find_by(id: params[:product_id])

    if product.nil?
      redirect_to cart_path
      flash[:error] = 'There was a problem adding this item to your cart.'
      return
    end

    quantity = order_params[:quantity].to_i

    if quantity <= 0
      flash[:error] = 'Please enter a quantity greater than 0.'
      # how to render the same page with flash?
    else
      if session[:order_id]
        @order = Order.find_by(id: session[:order_id])
        if @order.nil?
          flash[:error] = "Order no longer exists!"
          session[:order_id] = nil
          redirect_to cart_path
          return
        end
      else
        @order = Order.create
        session[:order_id] = @order.id
      end
      @order.add_product(product, quantity)
      flash[:success] = "#{product.name} added to cart!"
    end

    if product.stock < quantity
      flash[:error] = "Not enough #{product.name} in stock!"
    end
    @order.add_product(product, quantity)
    flash[:success] = "#{product.name} added to cart!"

    redirect_to cart_path
  end

  def destroy
    order_item = OrderItem.find_by(id: params[:id])  #use id from params not order_id
    if order_item.nil?
      flash[:error] = "Sorry, there was a problem. Could not remove item from cart"
      redirect_to cart_path
    else
      order_item.destroy
      flash[:success] = "#{order_item.product.name} removed from cart"
      return redirect_to cart_path
    end
  end

  def cart
    if session[:order_items].nil?
      flash[:error] = "You have nothing in your cart!"
      redirect_to root_path
    else
      @cart = OrderItem.display_items(session[:order_items])
      return @cart
    end
  end


    private
    def order_params
      return params.permit(:quantity, :product_id)
    end
end
