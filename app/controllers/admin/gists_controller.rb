class Admin::GistsController < ApplicationController
  before_action :set_admin_gist, only: %i[show]

  def index
    @gists = Gist.all
  end

  def show; end

  private

  def set_admin_gist
    @gist = Gist.find(params[:id])
  end

end
