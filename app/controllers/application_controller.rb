class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :remember_last_path
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(user)
    user.is_a?(Admin) ? admin_tests_path : root_path
  end

  private

  def remember_last_path
    path = request.original_fullpath
    cookies[:last_path] = path
  end
end
