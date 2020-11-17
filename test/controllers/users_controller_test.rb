require "test_helper"

describe UsersController do
  it "must get index" do
    get users_index_url
    must_respond_with :success
  end

  it "must get show" do
    get users_show_url
    must_respond_with :success
  end

  it "must get create" do
    get users_create_url
    must_respond_with :success
  end

  it "must get destroy" do
    get users_destroy_url
    must_respond_with :success
  end

end
