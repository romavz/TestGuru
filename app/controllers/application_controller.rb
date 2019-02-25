class ApplicationController < ActionController::Base
  before_action :remember_last_path

  protect_from_forgery with: :exception

  private

  def remember_last_path
    path = request.original_fullpath
    cookies[:last_path] = path
  end
end
