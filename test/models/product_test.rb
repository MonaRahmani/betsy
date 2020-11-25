require "test_helper"

describe Product do
  describe "validations" do
    it "instance of Product with valid fields passes" do
      product = products(:product1)
      # p product.valid?
      # p product.errors.messages
      expect(product.valid?).must_equal true
    end

    it "must have a name" do
      product1 = products(:product1)
      product1.name = nil

      product2 = products(:product2)
      product2.name = "Valid Name"

      expect(product1.valid?).must_equal false
      expect(product1.errors.messages).must_include :name
      expect(product2.valid?).must_equal true
    end

    it "name must be unique" do
      product1 = products(:product1)
      product2 = products(:product2)
      product1.name = product2.name

      expect(product1.valid?).must_equal false
      expect(product1.errors.messages).must_include :name
    end

    it "needs a description" do
      product1 = products(:product1)
      product1.description = nil

      product2 = products(:product2)
      product2.description = "Valid desc"

      expect(product1.valid?).must_equal false
      expect(product2.valid?).must_equal true
    end

    it "needs a stock" do
      product = products(:product1)
      product.stock = nil

      product2 = products(:product2)
      product2.stock = 3

      expect(product.valid?).must_equal false
      expect(product2.valid?).must_equal true
    end

    it "stock needs to be numeric" do
      product = products(:product1)
      product.stock = "Y1892"

      expect(product.valid?).must_equal false
    end

    it "stock needs to be positive" do
      product = products(:product1)
      product.stock = -1

      expect(product.valid?).must_equal false
    end

    it "needs a price" do
      product = products(:product1)
      product.price = nil

      product2 = products(:product2)
      product2.price = 3

      expect(product.valid?).must_equal false
      expect(product2.valid?).must_equal true
    end

    it "price needs to be numeric" do
      product = products(:product1)
      product.price = "Y1892"

      expect(product.valid?).must_equal false
    end

    it "price needs to be positive" do
      product = products(:product1)
      product.price = -1

      expect(product.valid?).must_equal false
    end

    it "doesn't need a photo url" do
      product = products(:product1)
      product.photo_url = nil

      expect(product.valid?).must_equal true
    end

    it "needs categories" do
      product1 = products(:product1)
      product1.categories = []

      # product2 = products(:product2)
      # product2.categories = nil

      expect(product1.valid?).must_equal false
      # expect(product2.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "product belongs to a user" do
      product1 = products(:product1)

      expect(product1.user).must_be_instance_of User
    end

    it "product has many categories" do
      product1 = products(:product1)
      product1.categories << categories(:category2)

      expect(product1.categories.count).must_equal 2
      # expect(product1.categories).must_be_instance_of Category
    end

    it "has many order items" do
      product1 = products(:product1)

      expect(product1.order_items.count).must_equal 2
      # expect(product1.order_items).must_be_instance_of OrderItem
    end
  end

  describe "active_only method" do
    it "filters out retired products" do
      expect(Product.active_only.count).must_equal 3
    end
  end
end
