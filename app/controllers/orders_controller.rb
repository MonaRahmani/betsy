class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      flash[:error] = 'Sorry, that order no longer exists.'
      redirect_to root_path
    elsif @order.update(order_params)
      flash[:success] = 'Order has been updated.'
      session[:order_id] = nil
      @order.update_order_status
      render :confirmation
    else
      flash[:error] = "A problem occurred. The order was not updated."
      flash[:reasons] = @order.errors.messages
      redirect_back fallback_location: '/'
      return
    end
  end

  def cart
    if session[:order_id].nil?
      flash[:error] = 'Your cart is empty...'
      redirect_to root_path
    else
      @order = Order.find_by(id: session[:order_id])
      @cart = @order.display_items
    end
  end

  def show
    # side note, changing from session[:order_id] to params[:id] for order works
    @order = Order.find_by(id: params[:id])
    @current_user = User.find_by(id: session[:user_id])

    if @order.nil?
      return head :not_found
    end
  end

  def confirmation
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      return head :not_found
    end
  end


  private

  def order_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year, :status)
  end
end
