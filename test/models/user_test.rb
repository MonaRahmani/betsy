require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "relationships" do
    it "has many products" do
      user = User.first
      Product.create(name: "test product", price: 100, stock: 10, user_id: user.id)

      expect(user).must_respond_to :products
      user.products.each do |product|
        expect(product).must_be_kind_of Product
        expect(product).must_be_instance_of Product
      end
    end
  end
end
