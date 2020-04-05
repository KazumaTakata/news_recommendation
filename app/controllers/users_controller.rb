class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(email: params["email"], password: params["password"])
    if @user.save
      log_in @user
      redirect_to root_path 
    else
      debugger
      flash.now[:alert] = @user.errors.full_messages 
      render 'new'
    end
  end
end
