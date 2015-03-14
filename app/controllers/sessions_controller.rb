class SessionsController < ApplicationController
  before_action :require_not_logged_in, only: [:new, :create]
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = 'Invalid login'
      @user = User.new(username: params[:session][:username])
      render :new
    end
  end

  def destroy
    user = current_user
    user.reset_session_token!
    session[:token] = nil
    redirect_to root_url
  end
end
