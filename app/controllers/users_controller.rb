class UsersController < ApplicationController

  before_action :check_login

  def new
    @user = User.new
    render :sign_up
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_session
    else
      render :sign_up
    end
  end


end
