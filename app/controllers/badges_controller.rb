class BadgesController < ApplicationController

  def index
    @user_badges = current_user.badges
    @all_badges = Badge.all
  end

end
