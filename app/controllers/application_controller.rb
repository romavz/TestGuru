class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :remember_last_path
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, only: [:create], if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_in_path_for(user)
    user.admin? ? admin_tests_path : root_path
  end

  private

  def remember_last_path
    path = request.original_fullpath
    cookies[:last_path] = path
  end
end
