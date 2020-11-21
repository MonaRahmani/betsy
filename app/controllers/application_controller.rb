class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session


  def find_user
     @logged_in_user = User.find_by(id: session[:user_id])
  end

end
