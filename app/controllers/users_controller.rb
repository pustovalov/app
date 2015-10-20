class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
    else
      render "new"
    end
  end
  
  private
    def card_params
      params.require(:card).permit(:email, :password)
    end
end
