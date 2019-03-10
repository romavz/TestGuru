class Admin::GistsController < ApplicationController
  before_action :set_admin_gist, only: %i[show]

  def index
    @gists = Gist.all
  end

  def show; end

  # DELETE /admin/gists/1
  # def destroy
  #   @admin_gist.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_gists_url, notice: 'Gist was successfully destroyed.' }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_gist
    @gist = Gist.find(params[:id])
  end

end
