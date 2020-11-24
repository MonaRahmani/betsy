require "test_helper"

describe OrderItemsController do
  describe "cart" do
    it "will redirect if session[order_items] is nil" do
      get cart_path
      must_redirect_to root_path
      flash[:error].must_equal "You have nothing in your cart!"
    end
  end

end
