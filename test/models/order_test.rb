require "test_helper"

describe Order do
  describe "validations" do
    it "instance of Order with valid fields passes" do
      order = orders(:order1)
      # p order.valid?
      # p order.errors.messages
      expect(order.valid?).must_equal true
    end

    it "must have credit_card_name" do
      order = orders(:order1)
      order.credit_card_name = nil
      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :credit_card_name
    end

    it "must have credit_card_num" do
      order1 = orders(:order1)
      order1.credit_card_num = nil

      order2 = orders(:order2)
      order2.credit_card_num = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :credit_card_num
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :credit_card_num
    end

    it "credit_card_num should be 16 characters" do
      order1 = orders(:order1)
      order1.credit_card_num = "2342424"

      order2 = orders(:order2)
      order2.credit_card_num = "23"

      order3 = orders(:order3)
      order3.credit_card_num = "1234567890123456"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :credit_card_num
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :credit_card_num
      expect(order3.valid?).must_equal true
    end

    it "must have cvv_num" do
      order1 = orders(:order1)
      order1.cvv_num = nil

      order2 = orders(:order2)
      order2.cvv_num = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cvv_num
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cvv_num
    end

    it "cvv_num should be 3 characters" do
      order1 = orders(:order1)
      order1.cvv_num = "2342424"

      order2 = orders(:order2)
      order2.cvv_num = "23"

      order3 = orders(:order3)
      order3.cvv_num = "123"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cvv_num
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cvv_num
      expect(order3.valid?).must_equal true
    end

    it "must have cc_exp_month" do
      order1 = orders(:order1)
      order1.cc_exp_month = nil

      order2 = orders(:order2)
      order2.cc_exp_month = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cc_exp_month
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cc_exp_month
    end

    it "must have cc_exp_year" do
      order1 = orders(:order1)
      order1.cc_exp_year = nil

      order2 = orders(:order2)
      order2.cc_exp_year = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cc_exp_year
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cc_exp_year
    end

    it "cc_exp_month should be an integer between 1-12" do
      order1 = orders(:order1)
      order1.cc_exp_month = 0

      order2 = orders(:order2)
      order2.cc_exp_month = 13

      order3 = orders(:order3)
      order3.cc_exp_month = 6

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cc_exp_month
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cc_exp_month
      expect(order3.valid?).must_equal true
      expect(order3.errors.messages).must_include :cc_exp_month
    end

    it "must have an email" do
      order1 = orders(:order1)
      order1.email = nil

      order2 = orders(:order2)
      order2.email = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :email
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :email
    end

    it "email must be valid" do
      order1 = orders(:order1)
      order1.email = "no_at_symbol.com"

      order2 = orders(:order2)
      order2.email = "no_period@gmail"

      order3 = orders(:order3)
      order3.email = "validemail@dream-team.com"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :email
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :email
      expect(order3.valid?).must_equal true
    end

    it "must have a street_address" do
      order1 = orders(:order1)
      order1.street_address = nil

      order2 = orders(:order2)
      order2.street_address = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :street_address
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :street_address
    end

    it "must have a city" do
      order1 = orders(:order1)
      order1.city = nil

      order2 = orders(:order2)
      order2.city = ""

      order3 = orders(:order2)
      order3.city = "Brookline"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :city
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :city
      expect(order3.valid?).must_equal true
      expect(order3.errors.messages).must_include :city
    end

    it "must have a state" do
      order1 = orders(:order1)
      order1.state = nil

      order2 = orders(:order2)
      order2.state = ""

      order3 = orders(:order2)
      order3.state = "MA"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :state
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :state
      expect(order3.valid?).must_equal true
      expect(order3.errors.messages).must_include :state
    end

    it "must have cvv_num" do
      order1 = orders(:order1)
      order1.cvv_num = nil

      order2 = orders(:order2)
      order2.cvv_num = ""

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :cvv_num
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :cvv_num
    end

    it "zip code should be 5 characters long" do
      order1 = orders(:order1)
      order1.zip_code = "2342424"

      order2 = orders(:order2)
      order2.zip_code = "23"

      order3 = orders(:order3)
      order3.zip_code = "12345"

      expect(order1.valid?).must_equal false
      expect(order1.errors.messages).must_include :zip_code
      expect(order2.valid?).must_equal false
      expect(order2.errors.messages).must_include :zip_code
      expect(order3.valid?).must_equal true
    end
  end

  describe "relationships" do
    it "has many order items" do
      order1 = orders(:order1)
      expect(order1.order_items.count).must_equal 2
    end
  end

  describe "add product" do
    it "if product isnt already in cart creates new instance of OrderItem" do
      product1 = products(:product1)
      order2 = orders(:order2) # order2 doesn't have any product1s in it (fixture)
      quantity = 1 # stock of product1 is 1 (edge case)

      expect(OrderItem.count).must_equal 5
      order2.add_product(product1, quantity)
      expect(OrderItem.count).must_equal 6
    end

    it "if product is already in cart updates quantity doesnt create new instance or OrderItem" do
      product3 = products(:product3)
      order5 = orders(:order5) # order5 already has 3 product3s in it
      quantity = 3

      expect(OrderItem.count).must_equal 5
      order5.add_product(product3, quantity)
      expect(OrderItem.count).must_equal 5
    end

    it "cant add item to cart if its retired" do #TODO perhaps move this to order_items controller
      product4 = products(:product4) # product4 is retired and has a stock of 4
      order1 = orders(:order1)
      quantity = 3

      expect(OrderItem.count).must_equal 5
      order1.add_product(product4, quantity)
      expect(OrderItem.count).must_equal 5
    end

    it "cant add more quantity than there is stock" do #TODO and this one as well
    end
  end

  describe "display_items" do

  end

  describe "total" do

  end

end
