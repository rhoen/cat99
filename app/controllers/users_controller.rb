class UsersController < ApplicationController


  def new
    @user = User.new
    render :sign_up
  end

  def create

  end


end
