require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success" do
      get users_path
      must_respond_with :success
    end
  end


  # describe "show" do
  #   it "responds with success when showing an existing user" do
  #     get user_path(user.first.id)
  #     must_respond_with :success
  #   end
  #
  #   it "responds with head: not_fount when user_id isn't fount" do
  #     get user_path(-1)
  #     must_respond_with :not_found
  #   end
  # end

  # describe "logout" do
  #   it "logs user out when they click logout"
  #   post logout_path
  #   expect(flash[:result_text]).must_equal "successfully logged out"
  #   must_respond_with :redirect
  #   must_redirect_to root_path
  # end

  # it "must get create" do
  #   get users_create_url
  #   must_respond_with :success
  # end
  #
  # it "must get destroy" do
  #   get users_destroy_url
  #   must_respond_with :success
  # end

end
