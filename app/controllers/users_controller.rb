class UsersController < ApplicationController

  before_action :not_logged_in

  def new
    @user = User.new
    render :sign_up
  end

  def create
    fail
    @user = User.new(user_params)
    if @user.save
      set_session
    else
      render :sign_up
    end
  end


end
