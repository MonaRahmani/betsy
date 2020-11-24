require "test_helper"

describe OrdersController do
  describe "show" do
    it "will show an order" do
      order = orders(:order1)
      get order_path(order.id)
      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success" do
      Order.new(
          {
              email: "Test title",
              street_address: "Test address",
              city: "test city",
              state: "test state",
              zip_code: "test code",
              cvv_num: "333",
              cc_exp_month: "12",
              cc_exp_year: "2021"
          }
      )
      get new_order_path
      must_respond_with :success
    end
  end

  describe "edit" do
    it "responds with success" do
      order = orders(:order1)
      get order_path(order.id)
      must_respond_with :success
    end
  end
end
