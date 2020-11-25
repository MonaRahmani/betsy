require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success" do
      get root_path
      must_respond_with :success
    end
  end

  it "must get create" do
    get users_path
    must_respond_with :success
  end

  describe "show" do
    it "responds with success when showing an existing user" do
      valid_user = users(:user1)
      get user_path(valid_user)
      must_respond_with :success
    end

    it "responds with head: not_found when user_id isn't fount" do
      get user_path(-1)
      must_respond_with :not_found
    end
  end
  describe "create" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, make sure we are not creating a new user every time we get a login request
      start_count = User.count

      # Get a user from the fixtures
      user = users(:user1)

      # Tell OmniAuth to use this user's info when it sees an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Send a login request for that user
      get auth_callback_path(:github)

      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      session[:user_id].must_equal user.id

      # Should *not* have created a new user
      User.count.must_equal start_count
    end

    it "creates a new user" do
      start_count = User.count
      user = User.create(provider: "github", uid: 99999, username: "test_user", email: "test@user.com")

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      must_redirect_to root_path

      # Should have created a new user
      User.count.must_equal start_count + 1

      # The new user's ID should be set in the session
      session[:user_id].must_equal User.last.id

      flash[:success].must_equal "Logged in as returning user #{user.username}"
    end

    it "redirects to the root path if given invalid user data" do

      invalid_user = User.create(provider: "github", uid: 99999, username: nil, email: "test@user.com")
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(invalid_user))
      get auth_callback_path(:github)
      must_redirect_to root_path
    end


    describe "destroy action" do
      it "can logout a user" do
        user = users(:user1)
        perform_login(user)

        delete logout_path

        must_redirect_to root_path
        refute(session[:user_id])
      end
    end

  end
end
