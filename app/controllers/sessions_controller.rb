class SessionsController < ApplicationController
  before_action :check_login, except: [:destroy]

  def create
    @user = User.find_by_credentials(user_params[:user_name],
      user_params[:password])
    if @user
      set_session
    else
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_sessions_url
  end


  def new
    @user = User.new
    render :new
  end


end
