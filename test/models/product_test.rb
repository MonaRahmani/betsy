require "test_helper"

describe Product do
  describe "validations" do
    it "instance of Product with valid fields passes" do
      product = products(:product1)
      # p product.valid?
      # p product.errors.messages
      product.categories = Category.where(category_name: "Emotion")

      p product
      expect(product.valid?).must_equal true


    end

    it "must have a name" do
      product = products(:product1)
      product.name = nil
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :name
    end

    it "name must be unique" do
      product1 = products(:product1)
      product2 = products(:product2)
      product1.name = product2.name

      expect(product1.valid?).must_equal false
      expect(product1.errors.messages).must_include :name
    end

    it "needs a description" do
      product = products(:product1)
      product.description = nil
      expect(product.valid?).must_equal false
    end

    it "needs a stock" do
      product = products(:product1)
      product.stock = nil
      expect(product.valid?).must_equal false
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

    it "price needs to be numeric" do
      product = products(:product1)
      product.stock = "Y1892"
      expect(product.valid?).must_equal false
    end

    it "price needs to be positive" do
      product = products(:product1)
      product.stock = -1
      expect(product.valid?).must_equal false
    end

    it "doesn't need a photo url" do
      product = products(:product1)
      product.photo_url = nil
      expect(product.valid?).must_equal true
    end

    it "needs categories" do
      product = products(:product1)
      product.categories = nil
      expect(product.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      merchant = User.create!(id: 100, username: "Yoda", email: "yoda@starwars.com", uid: 332, provider: "github")
      product_sample = Product.create!(name: "Tester", description: "Blah", price: 150.00, stock: 2, photo_url: "https://i.pinimg.com/564x/a9/f3/b1/a9f3b1e3aef96d52fca5e01d3fb22434.jpg", retired: false, user_id: 100)

      expect(product_sample.user).must_be_instance_of User
    end
  end
end
