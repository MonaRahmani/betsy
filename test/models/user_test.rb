require "test_helper"

describe User do
  describe "validations" do
    it "instance of User with valid fields passes" do
      user = users(:user1)
      expect(user.valid?).must_equal true
    end

    it "must have a username" do
      user1 = users(:user1)
      user1.username = nil

      user2 = users(:user2)
      user2.username = "Valid Name"

      expect(user1.valid?).must_equal false
      expect(user1.errors.messages).must_include :username
      expect(user2.valid?).must_equal true
    end

    it "username must be unique" do
      user1 = users(:user1)
      user2 = users(:user2)
      user1.username = user2.username

      expect(user1.valid?).must_equal false
      expect(user1.errors.messages).must_include :username
    end

    it "must have an email" do
      user1 = users(:user1)
      user1.email = nil

      user2 = users(:user2)
      user2.email = ""

      expect(user1.valid?).must_equal false
      expect(user1.errors.messages).must_include :email
      expect(user2.valid?).must_equal false
      expect(user2.errors.messages).must_include :email
    end

    it "email must be unique" do
      user1 = users(:user1)
      user2 = users(:user2)
      user1.username = user2.username

      expect(user1.valid?).must_equal false
      expect(user1.errors.messages).must_include :username
    end
  end

  describe "relationships" do
    it "has many Products" do
      user1 = users(:user1)
      expect(user1.products.count).must_equal 2
    end

    it "has many products" do
      user = User.first
      Product.create(name: "test product", price: 100, stock: 10, user_id: user.id)

      expect(user).must_respond_to :products
      user.products.each do |product|
        expect(product).must_be_kind_of Product
        expect(product).must_be_instance_of Product
      end
    end

    it "has many OrderItems through Products" do
      user2 = users(:user2)
      expect(user2.order_items.count).must_equal 2
    end
  end

  describe "build_from_github do" do
    # TODO
  end

  describe "total_rev_filtered takes in user sales and returns associated revenue" do
    it "if status is nil tallies all orders" do
      user1 = users(:user1)
      result = user1.total_rev_filtered(nil)
      expect(result).must_equal 12
    end

    it "if status is other expected value such as pending and paid" do
      user1 = users(:user1)
      result1 = user1.total_rev_filtered("paid")
      result2 = user1.total_rev_filtered("pending")
      expect(result1).must_equal 10
      expect(result2).must_equal 2
    end

    # TODO perhaps test for an unexpected value for status
  end

  describe "total_orders_by_status" do
    it "if status is nil tallies all orders" do
      user1 = users(:user1)
      result = user1.total_orders_by_status(nil)

      expect(result).must_equal 3
    end

    it "if status is other expected value such as pending and paid" do
      user1 = users(:user1)
      result1 = user1.total_orders_by_status("paid")
      result2 = user1.total_orders_by_status("pending")
      expect(result1).must_equal 2
      expect(result2).must_equal 1
    end
  end

  describe "sorted_products" do
    it "lists active items first followed by then retired items" do
      user1 = users(:user1)
      product1 = products(:product1)
      product1.retired = true #switching order here so that the method has to do some work!
      product2 = products(:product2)
      product2.retired = false

      result = user1.sorted_products
      expect(result.first).must_equal products(:product1)
      expect(result.count).must_equal 2
    end
  end
end
>>>>>>> master
