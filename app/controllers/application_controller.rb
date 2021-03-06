class ApplicationController < ActionController::Base

  def categories_method
    @categories = Category.all
  end

  def current_user
    return @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if find_logged_user.nil?
      flash[:error] = "You must be logged in first."
      redirect_to root_path
    end
  end
end
