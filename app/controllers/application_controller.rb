class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session

  def categories_method
    @categories = Category.all
  end

  def find_current_user
   @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if find_logged_user.nil?
      flash[:error] = "You must be logged in first."
      redirect_to root_path
    end
  end

end
