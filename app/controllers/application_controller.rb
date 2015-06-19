class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :log_out, :current_user, :is_admin?, :is_creator?



  def logged_in?
    session[:user_id] ? true : false
  end

  def is_admin?
    current_user.role == 'admin'
  end

  def is_creator?(post)
    current_user.id == post.user_id

  end


  def log_out
    session[:user_id]  = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    access_denied unless logged_in?
  end

  

  def require_admin
    access_denied unless logged_in? && is_admin?
  end

  private
  def access_denied
    flash[:error] = "You can't do that!"
    redirect_to root_path
  end
  
end
