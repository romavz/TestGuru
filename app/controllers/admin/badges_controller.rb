class Admin::BadgesController < Admin::BaseController

  before_action :load_badge, only: %i[edit update destroy update_inline]
  before_action :load_rewarding_rules_translate, only: %i[new create edit update index]

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

  def update_inline
    if @badge.update(badge_params)
      redirect_to admin_badges_path
    else
      render :index
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

  def load_rewarding_rules_translate
    t_path = "badges.rewarding_rules"
    # @rewarding_rules = Badge::REWARDING_RULES.map { |rule| [rule.to_s, t("#{t_path}.#{rule}")] }
    @rewarding_rules = Badge::REWARDING_RULES.map { |rule| [rule.to_s, t("#{t_path}.#{rule}")] }.to_h
  end

  def badge_params
    params.require(:badge).permit(:title, :image_path, :rule_name, :rule_value, :multiple)
  end

end
