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









  #
  #   it "needs a description" do
  #     order = orders(:order1)
  #     order.description = nil
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "needs a stock" do
  #     order = orders(:order1)
  #     order.stock = nil
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "stock needs to be numeric" do
  #     order = orders(:order1)
  #     order.stock = "Y1892"
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "stock needs to be positive" do
  #     order = orders(:order1)
  #     order.stock = -1
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "price needs to be numeric" do
  #     order = orders(:order1)
  #     order.price = "Y1892"
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "price needs to be positive" do
  #     order = orders(:order1)
  #     order.price = -1
  #     expect(order.valid?).must_equal false
  #   end
  #
  #   it "doesn't need a photo url" do
  #     order = orders(:order1)
  #     order.photo_url = nil
  #     expect(order.valid?).must_equal true
  #   end
  #
  #   it "needs categories" do
  #     order = orders(:order1)
  #     order.categories = []
  #     expect(order.valid?).must_equal false
  #   end
  end
end
