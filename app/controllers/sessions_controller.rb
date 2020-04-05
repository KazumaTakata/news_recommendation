class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      flash.now[:danger] = 'login success!!' 
      redirect_to root_path 
    else
      flash.now[:danger] = 'Invalid email/password combination' 
      render 'new'

    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
