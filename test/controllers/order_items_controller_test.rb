require "test_helper"

describe OrderItemsController do

  let(:product){
    products(:product1)
  }

  let(:product3){
    products(:product3)
  }

  let(:order){
    products(:order1)
  }


  describe 'create' do

    it "will create a valid order item" do

      new_valid_order_item = {
          quantity: 1,
          product_id: product.id
      }

      expect {
        post product_order_items_path(product.id), params: new_valid_order_item
      }.must_change "OrderItem.count", 1

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "will not create invalid order item, 0 quantity" do

      invalid_order_item = {
          quantity: 0,
          product_id: product.id
      }

      expect {
        post product_order_items_path(product.id), params: invalid_order_item
      }.wont_change "OrderItem.count"

      must_respond_with :redirect

    end

    it "will redirect when product is nil" do

      invalid_order_item_nil = {
              quantity: 1,
              product_id: nil
      }

      post product_order_items_path(product.id), params: invalid_order_item_nil
      must_respond_with :redirect
    end

    it "will redirect when order is nil" do

      invalid_order_item_nil = {
              quantity: 1,
              product_id: product.id,
              order: nil
      }

      post product_order_items_path(product.id), params: invalid_order_item_nil
      must_respond_with :redirect

    end

    it "will redirect if order_item is invalid and cannot be created" do

      invalid_order_item = {
              quantity: 1,
              product_id: nil,
              order: nil
      }

      post product_order_items_path(product.id), params: invalid_order_item
      must_respond_with :redirect
    end

    it "will not create invalid order item, quantity selected is greater than stock available" do

      invalid_order_item = {
          quantity: 4,
          product_id: product3.id
      }

      expect {
        post product_order_items_path(product.id), params: invalid_order_item
      }.wont_change "OrderItem.count"
      must_respond_with :redirect

    end
  end

  describe "destroy" do
    it "will destroy an existing order item" do
      order_item = order_items(:order_item1)

      expect {
        delete product_order_item_path(order_item.order_id, order_item.id)
      }.must_change "OrderItem.count", -1
    end


    it "will redirect when given an invalid order item" do
      order_item = order_items(:order_item1)

      delete product_order_item_path(order_item.order_id, -100)

      must_respond_with :redirect
    end
  end

  describe "cart" do
    it "will redirect if session[order_items] is nil" do
      get cart_path
      must_redirect_to root_path
      flash[:error].must_equal "Cart Empty! Please add a product to cart."
    end
  end

end
