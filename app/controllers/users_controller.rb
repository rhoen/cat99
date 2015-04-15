class UsersController < ApplicationController


  def new
    @user = User.new
    render :sign_up
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      render :sign_up
    end
  end


private
def user_params
  params.require(:user).permit(:user_name, :password)
end

end
