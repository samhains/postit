class SessionsController < ApplicationController
  def new
    @session
  end  

  def create

    @user = User.find_by username: params[:username]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Successfully Logged In!"
      redirect_to root_path
    else
      flash[:error] = "Something Wrong with your Log In!"
      render 'sessions/new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have been logged out!"
    redirect_to root_path

  end
  
end