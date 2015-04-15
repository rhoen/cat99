class SessionsController < ApplicationController


  def create
    @user = User.find_by_credentials(user_params[:user_name],
      user_params[:password])
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
  end


  def new
    @user = User.new
    render :new


  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end


end
