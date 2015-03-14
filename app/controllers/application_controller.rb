class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_user!(user)
    session[:token] = user.reset_session_token!
  end

  def require_login
    unless logged_in?
      flash[:errors] = "You must be signed in"
      redirect_to new_session_url
    end
  end

  def require_not_logged_in
    if logged_in?
      flash[:errors] = "You are signed in"
      redirect_to root_url
    end
  end

end
