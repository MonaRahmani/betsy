require "test_helper"

describe ProductsController do
  it "must get index" do
    get products_index_url
    must_respond_with :success
  end

  it "must get show" do
    get products_show_url
    must_respond_with :success
  end

  it "must get new" do
    get products_new_url
    must_respond_with :success
  end

  it "must get edit" do
    get products_edit_url
    must_respond_with :success
  end

end
