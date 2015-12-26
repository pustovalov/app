class Home::PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    @user.deliver_reset_password_instructions! if @user
    flash[:success] = t("notifications.email_sent")
    redirect_to log_in_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated && return if @user.blank?

    if @user.change_password!(params[:user][:password])
      flash[:success] = t("notifications.password_updated")
      redirect_to log_in_path
    else
      render "edit"
    end
  end
end
