require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success" do
      get root_path
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
  describe "create" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = User.count

      # Get a user from the fixtures
      user = users(:user1)

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Send a login request for that user
      # Note that we're using the named path for the callback, as defined
      # in the `as:` clause in `config/routes.rb`
      get auth_callback_path(:github)

      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      session[:user_id].must_equal user.id

      # Should *not* have created a new user
      User.count.must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do
    end

    it "redirects to the login route if given invalid user data" do
    end
  end


  # describe "logout" do
  #   it "logs user out when they click logout"
  #   post logout_path
  #   expect(flash[:result_text]).must_equal "successfully logged out"
  #   must_respond_with :redirect
  #   must_redirect_to root_path
  # end
  #
  # it "must get create" do
  #   get users_create_path
  #   must_respond_with :success
  # end
  #
  # it "must get destroy" do
  #   get users_destroy_path
  #   must_respond_with :success
  # end

end
