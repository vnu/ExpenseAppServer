class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   # protect_from_forgery# with: :null_session

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def require_authentication
    unless current_user
      redirect_to root_path, notice: "Please Sign in"
    end
  end

  def require_email
    unless current_user.email.present?
      redirect_to signup_path, notice: "Please complete your signup"
    end
  end

  def format_json
    request.format.json?
  end

  helper_method :current_user
end
