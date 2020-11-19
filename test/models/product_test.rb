require "test_helper"

describe Product do
  describe "relationships" do
    it "belongs to a user" do
      merchant = User.create!(id: 100, username: "Yoda", email: "yoda@starwars.com", uid: 332, provider: "github")
      product_sample = Product.create!(name: "Tester", description: "Blah", price: 150.00, stock: 2, photo_url: "https://i.pinimg.com/564x/a9/f3/b1/a9f3b1e3aef96d52fca5e01d3fb22434.jpg", retired: false, user_id: 100)

      expect(product_sample.user).must_be_instance_of User
    end
  end
end
