class ApplicationController < ActionController::Base
  ALERT_MESSAGE = "Are You a Guru? Verify your Email and Password please".freeze

  before_action :remember_last_path
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  helper_method :current_user,
                :logged_in?

  private

  def remember_last_path
    path = request.original_fullpath
    cookies[:last_path] = path
  end

  def authenticate_user!
    redirect_to login_path, alert: ALERT_MESSAGE unless logged_in?
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id) if user_id.present?
  end

  def logged_in?
    current_user.present?
  end
end
