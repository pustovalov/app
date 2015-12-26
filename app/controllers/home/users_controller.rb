class Home::UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path
    else
      render "new"
    end
  end

  def settings
    render template: "home/users/settings"
  end

  def edit
  end

  def update
    if User.authenticate(current_user.email, params[:user][:password]) || current_user.external?
      if current_user.update(user_params)
        current_user.change_password!(params[:user][:new_password]) if params[:user][:new_password]
        flash[:success] = t("notifications.success")
        redirect_to settings_path
      else
        flash[:error] = t("notifications.try_again")
        redirect_to :back
      end
    else
      flash[:error] = t("notifications.password_wrong")
      redirect_to :back
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :locale)
  end
end
