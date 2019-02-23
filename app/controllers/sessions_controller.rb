class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  skip_before_action :remember_last_path

  def new
    # request.reset_session
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies.delete(:last_path) || rooth_path
    else
      flash.now[:alert] = "Are you a Guru? Verify your Email and Password please"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
