class UsersController < ApplicationController
  before_action :find_logged_user, only: [:current]

  def index
    @users = User.all
    @products = Product.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
      return
    end
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    # Check to see if there's already a User record matching the credentials of uid and provider in our db
    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.username}"
    else
      # User doesn't match anything in the DB, Attempt to create a new user
      user = User.build_from_github(auth_hash)
      if user.save
        flash[:success] = "Logged in as new user #{user.username}"
      else
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end
    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    redirect_to root_path
    return
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
  
  def user_dashboard
    @user = User.find_by(id: params[:id])
    if session[:user_id] != @user.id
      flash[:error] = "HEY! Not your page."
      redirect_to root_path
    end
  end
end
