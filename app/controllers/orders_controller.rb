class OrdersController < ApplicationController

  def cart
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "order not found"
      redirect_to root_path
    end
  end

  # def show
  #
  # end


  def edit
  end

  def new
    @order = Order.new
  end

  def check_out
    @order = Order.find_by(id: session[:order_id])
  end


  private

  def user_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year)
  end
end
