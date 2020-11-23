class OrdersController < ApplicationController
  before_action :find_logged_user, only: [:show]

  def cart
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "Your cart is empty!"
      redirect_to root_path
    end
  end

  def create
    if session[:order_id] #checking for guest items in cart and creating an order
      @order = Order.new(order_params)
    else
      @order = Order.new #if there are 0 items in cart, create a new order
      session[:order_id] = @order.id
    end
    if @order.save
      session[:order_id] = @order.id
      flash[:success] = "Order was created!"
      redirect_to order_path(@order.id)
      return
    else
      flash[:error] = "Could not create order."
      redirect_to root_path
      return
    end
  end

  def show
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "cant update, order dose not exist"
      redirect_to root_path
    elsif @order.update(order_params)
      flash[:success] = "order has been submited"
      render :show
    else
      flash[:error] = "order can't be submited"
      redirect_to cart_path
      return
    end
  end


  def edit
  end

  def new
    @order = Order.new
  end

  def check_out
    @order = Order.find_by(id: session[:order_id])
  end


  private

  def order_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year)
  end
end
