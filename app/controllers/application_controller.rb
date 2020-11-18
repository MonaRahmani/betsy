class ApplicationController < ActionController::Base


  private

  def find_user
    if session[:user_id]
      @logged_in_user = User.find_by(id: session[:user_id])
    end
  end
end
