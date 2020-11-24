class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      flash[:error] = "Sorry, you do not have access to this page."
      redirect_to root_path
    elsif @order.update(order_params)
      flash[:success] = "Order has been submitted"
      session[:order_id] = nil
      render :confirmation
      # TODO update inventory here
      # consider first creating the shopping cart as pending, and set to paid here?
    else
      flash[:error] = "Order wasn't submitted:"
      flash[:reasons] = @order.errors.messages
      redirect_back fallback_location: '/'
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
    @order = Order.find_by(id: params[:id])   #changing from sessions[:order_id] to params[:id], works
    @logged_user = User.find_by(id: session[:user_id])

    # anyone can view this page, how to prevent that.
    # if session[:user_id] != @logged_user
    #   flash[:error] = "Sorry, you cannot access this page."
    #   redirect_to root_path
    # end
  end

  def confirmation
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      return head :not_found
    end
  end


  # def check_out
  #   @order = Order.find_by(id: session[:order_id])
  #   if @order.nil?
  #     flash[:error] = "Sorry, we can't complete your checkout because that order no longer exists."
  #     return redirect_to root_path
  #   end
  # end


  private

  def order_params
    return params.require(:order)
               .permit(:email, :street_address, :city, :state, :zip_code, :credit_card_name,
                       :credit_card_num, :cvv_num, :cc_exp_month, :cc_exp_year)
  end
end
