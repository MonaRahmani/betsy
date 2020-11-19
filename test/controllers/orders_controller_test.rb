require "test_helper"

describe OrdersController do
  # it "must get index" do
  #   get orders_index_url
  #   must_respond_with :success
  # end

  it "must get show" do
    order = orders(:order1)
    get order_path(order.id)
    must_respond_with :success
  end

  # it "must get edit" do
  #   get orders_edit_url
  #   must_respond_with :success
  # end

  # it "must get new" do
  #   get orders_new_url
  #   must_respond_with :success
  # end

end
