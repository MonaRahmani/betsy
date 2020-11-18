require "test_helper"

# describe ProductsController do
#   describe "index" do
    # it "must get index" do
    #   get products_path
    #   must_respond_with :success
    # end
  # end

  # describe "show" do
    # it "must get show" do
    #   get product_path()
    #   must_respond_with :success
    # end
    #
    # it "can redirect if there's an invalid product id" do
    #   get product_path(-1)
    #
    #   must_redirect_to products_path
    # end
  # end

  # describe "new" do
    # it "must get new" do
    #   get new_product_path
    #   must_respond_with :success
    # end
  # end

  # describe "create" do
  #   it "can create a new product" do
  #     product_hash = {
  #         product: {
  #             name: "New Product",
  #             description: "Great new product",
  #             price: 10.50,
  #             photo_url: "www.newimage.com",
  #             stock: 5,
  #             retired: false
  #         },
  #     }
  #
  #     expect {
  #       post products_hash, params: product_hash
  #     }.must_change "Product.count", 1
  #
  #     new_product = Product.find_by(name: product_hash[:product][:name])
  #     expect(new_product.name).must_equal product_hash[:product][:name]
  #     expect(new_product.description).must_equal product_hash[:product][:description]
  #     expect(new_product.price).must_equal product_hash[:product_hash][:price]
  #     expect(new_product.photo_url).must_equal product_hash[:product_hash][:photo_url]
  #     expect(new_product.stock).must_equal product_hash[:product_hash][:stock]
  #     expect(new_product.retired).must_equal false
  #
  #     must_respond_with :redirect
  #     must_redirect_to product_hash(new_product.id)
  #   end
  # end
  #
  # describe "edit" do
  #   it "must get edit" do
  #     get edit_product_path()
  #
  #     must_respond_with :success
  #   end
  #
  #   it "can redirect if product to edit doesn't exist" do
  #     get edit_product_path(-1)
  #
  #     must_respond_with :redirect
  #   end
  # end

  # describe "update" do
  #   it "can update an existing product" do
  #     #     product_hash = {
  #     #         product: {
  #     #             name: "New Product",
  #     #             description: "Great new product",
  #     #             price: 10.50,
  #     #             photo_url: "www.newimage.com",
  #     #             stock: 5,
  #     #             retired: false
  #     #         },
  #     #     }
  #     product_id = Product.first.id
  #
  #     expect {
  #       patch product_path(product_id) params: product_hash
  #     }.wont_change "Product.count"
  #
  #     must_redirect_to products_path
  #
  #     updated_product = Product.find_by(id: product_id)
  #     expect(updated_product.id).must_equal product_id
  #     expect(updated_product.name).must_equal product_hash[:product][:name]
  #   end
  # end

  # describe "destroy" do
  #   it "can destroy a product" do
  #     id = Product.first.id
  #
  #     expect {
  #       delete product_path(id)
  #     }.must_change "Product.count", -1
  #
  #     deleted_product = Product.find_by(id: id)
  #     expect(deleted_product).must_be_nil
  #
  #     must_respond_with :redirect
  #     must_redirect_to products_path
  #   end
  #
  #   it "can't destroy a product if it doesn't exist" do
  #     expect {
  #       delete product_path(-1)
  #     }.wont_change "Product.count"
  #
  #     must_respond_with :redirect
  #     must_redirect_to products_path
  #   end
  # end
# end
