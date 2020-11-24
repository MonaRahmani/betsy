class OrderItemsController < ApplicationController
  
  def create

    product = Product.find_by(id: params[:product_id])
    if product.nil?
      redirect_to cart_path
      flash[:error] = 'There was a problem adding this item to your cart.'
      return
    end

    quantity = order_items_params[:quantity].to_i
    order_item = OrderItem.new(order_items_params)
    if quantity <= 0
      flash[:error] = 'Please enter a quantity greater than 0.'
      return redirect_to product_path(order_item.product.id)
    end

    # Begin creating the order
    if session[:order_id]
      @order = Order.find_by(id: session[:order_id])

      if @order.nil?
        flash[:error] = "Order no longer exists!"
      end

    else
      @order = Order.new(status: 'pending')
      if @order.save
        session[:order_id] = @order.id
      else
        flash[:error] = @order.errors.full_messages
        redirect_to root_path
        return
      end
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

    private
  def order_items_params
    return params.permit(:quantity, :product_id)
  end
end
