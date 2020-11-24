class OrdersController < ApplicationController
  before_action :find_current_user, only: [:show, :cart]

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "cant update, order does not exist"
      redirect_to root_path
    elsif @order.update(order_params)
      flash[:success] = "order has been submitted"
      session[:order_id] = nil
      # TODO update inventory here
      # consider first creating the shopping cart as pending, and set to paid here?
      render :show
    else
      flash[:error] = "order can't be submitted"
      redirect_to cart_path
      return
    end
  end

  def cart
    if session[:order_id].nil?
      flash[:error] = "You have nothing in your cart!"
      redirect_to root_path
    else
      @order = Order.find_by(id: session[:order_id])
      @cart = @order.display_items
    end
  end

  def show
    @order = Order.find_by(id: session[:order_id])
    if session[:order_id] != @order.id
      flash[:error] = "HEY! Not your page."
      redirect_to root_path
    end
    
    if find_current_user.nil?
      head :not_found
      return
    end
  end

  def check_out
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "Sorry, we can't complete your checkout because that order no longer exists."
      return redirect_to root_path
    end
  end


  private

  def order_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year)
  end
end
