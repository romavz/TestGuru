class ApplicationController < ActionController::Base
  ALERT_MESSAGE = "Are You a Guru? Verify your Email and Password please".freeze

  before_action :last_path
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  helper_method :current_user,
                :logged_in?

  private

  def last_path
    path = request.original_fullpath
    cookies[:last_path] = path if path != login_path
  end

  def authenticate_user!
    redirect_to login_path, alert: ALERT_MESSAGE unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
