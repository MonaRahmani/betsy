class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
      return
    end
  end

  def create
  end

  def destroy
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out"
    redirect_to root_path
    return
  end

end
