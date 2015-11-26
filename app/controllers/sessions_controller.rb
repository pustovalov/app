class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:user][:email], params[:user][:password])
      flash[:success] = t("notifications.welcome_back")
      redirect_back_or_to root_path
    else
      flash.now[:warning] = t("notifications.email_password_incorrect")
      render "new"
    end
  end

  def destroy
    logout
    flash[:success] = t("notifications.bye")
    redirect_to log_in_path
  end
end
