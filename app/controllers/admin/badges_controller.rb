class Admin::BadgesController < Admin::BaseController

  before_action :load_badge, only: %i[edit update destroy update_inline]

  def index
    @badges = Badge.all
  end

  def show
    redirect_to admin_badges_path
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to [:admin, @badge], notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @badge.update(badge_params)
      redirect_to [:admin, @badge]
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def load_badge
    @badge = Badge.find_by(id: params[:id])
  end

  def badge_params
    params.require(:badge).permit(:title, :image_path, :rule_name, :rule_value)
  end

end
