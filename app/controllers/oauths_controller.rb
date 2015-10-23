class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = params[:provider]
    begin
      @user = create_from(provider)

      reset_session
      auto_login(@user)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    rescue
      redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
    end
  end

  private
    def auth_params
      params.permit(:code, :provider)
    end
end