class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    if params[:action] == "update"
      @current_user = User.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = "You must be logged in to do that."
      render js: "window.location.reload();"
    end
  end

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def require_admin
    access_denied unless logged_in? and current_user.is_admin?
  end

  def access_denied
    flash[:error] = "You are not authorized to do that."
    redirect_to root_path
  end

  def id_is_a_slug?
    params[:id].to_i.zero?
  end
end
