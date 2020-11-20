class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  before_action :set_cart

  private

  def set_cart
    @cart = Order.find_by(id: session[:order_id])
    if @cart.nil?
      @cart = Order.create
      session[:order_id] = @cart.id
    end
  end

  def find_user
    if session[:user_id]
      @logged_in_user = User.find_by(id: session[:user_id])
    end
  end

end
