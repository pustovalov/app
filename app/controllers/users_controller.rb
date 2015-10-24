class UsersController < ApplicationController
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
    render template: "users/settings"
  end

  def edit
  end

  def update
    password     = params[:user][:password]
    new_password = params[:user][:new_password]
    email        = params[:user][:email]

    if User.authenticate(current_user.email, password) || current_user.external?
      if email
        current_user.password = password
        current_user.email = email
        current_user.save
        flash[:success] = "Email was successfully updated."
      else
        if current_user.external? && email
          current_user.email = email
        end
        current_user.password = new_password
        current_user.save
        flash[:success] = "Password was successfully updated."
      end
      redirect_to settings_path
    else
      flash[:error] = "Wrong password"
      redirect_to :back
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :new_password)
  end
end
