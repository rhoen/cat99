class SessionsController < ApplicationController


  def create
  end

  def destroy
  end


  def new
    @user = User.new
    render :new


  end


end
