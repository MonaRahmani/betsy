require "test_helper"

describe ProductsController do
  # before do
  #   @product = Product.create(name: "Test Product", description: "Smelly test product", price: 5.00, photo_url: "http://photo.com", stock: 2, retired: false)
  # end
  # maybe get a products.yml file going to DRY up code
  describe "index" do
    it "must get index" do
      get products_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "must get show" do

      product_id = products(:product1).id

      get products_path(product_id) #why products plural?

      must_respond_with :success
    end

    it "can redirect if there's an invalid product id" do

      get product_path(-1)

      must_respond_with :redirect

      # must_redirect_to products_path
    end
  end

  describe "new" do
    it "must get new" do
      get new_product_path

      must_respond_with :success
    end
  end

  # describe "create" do TODO need to figure out how to set categories and users here.
  #   it "can create a new product" do
  #     product_hash = {
  #       product: {
  #         name: "New Product",
  #         description: "Great new product",
  #         price: 10,
  #         photo_url: "www.newimage.com",
  #         stock: 5,
  #         retired: false,
  #         categories: [ {id: categories(:category1).id} ],
  #         user_id: users(:user1).id
  #       },
  #     }
  #
  #     expect {
  #       post products_path, params: product_hash
  #     }.must_change "Product.count", 1
  #
  #     new_product = Product.find_by(name: product_hash[:product][:name])
  #     expect(new_product.name).must_equal product_hash[:product][:name]
  #     expect(new_product.description).must_equal product_hash[:product][:description]
  #     expect(new_product.price).must_equal product_hash[:product][:price]
  #     expect(new_product.photo_url).must_equal product_hash[:product][:photo_url]
  #     expect(new_product.stock).must_equal product_hash[:product][:stock]
  #     expect(new_product.retired).must_equal false
  #
  #     must_respond_with :redirect
  #     must_redirect_to product_path(new_product.id)
  #   end
  # end

  describe "edit" do
    it "must get edit" do
      product = products(:product1)

      get edit_product_path(product)

      must_respond_with :success
    end

    it "can redirect if product to edit doesn't exist" do
      get edit_product_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing product" do
      product_hash = {
        product: {
          name: "New Product",
          description: "Great new product",
          price: 10.50,
          photo_url: "www.newimage.com",
          stock: 5,
          retired: true
        },
      }
      product_id = products(:product1).id

      patch product_path(product_id), params: product_hash

      expect {
        patch product_path(product_id), params: product_hash
      }.wont_change "Product.count"
      # must_redirect_to product_path(product_id)
      must_respond_with :success
      updated_product = Product.find_by(id: product_id)
      expect(updated_product.name).must_equal product_hash[:product][:name]

    end
  end

  describe "destroy" do
    it "can destroy a product" do
      product = products(:product1)
      id = product.id

      expect {
        delete product_path(id)
      }.must_change "Product.count", -1

      deleted_product = Product.find_by(id: id)
      expect(deleted_product).must_be_nil

      must_respond_with :redirect
      must_redirect_to products_path
    end

    it "can't destroy a product if it doesn't exist" do
      expect {
        delete product_path(-1)
      }.wont_change "Product.count"

      must_respond_with :redirect
      must_redirect_to products_path
    end
  end
end