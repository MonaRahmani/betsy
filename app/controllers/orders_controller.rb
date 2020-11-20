class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      head :not_found
      return
    end
  end

  def edit
  end

  def new
    @order = Order.new
  end

  private

  def user_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year)
  end
end
