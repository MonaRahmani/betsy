class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    @cart = Order.find_by(id: session[:order_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Order.create
    session[:order_id] = @order.id
  end

  def find_user
    if session[:user_id]
      @logged_in_user = User.find_by(id: session[:user_id])
    end
  end

end
