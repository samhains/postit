class UsersController < ApplicationController
  before_action :require_user, except: [:create, :vote, :new]
  before_action :get_user, only: [:show, :update, :edit]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created successfully"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end

  end

  def show
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:notice] = "User has been updated successfully"
      redirect_to edit_user_path
    else
      render 'edit'
    end

  end



  def edit
  end

  def vote
    render json:{vote:current_user.votes}
    
  end

  private
  def user_params
    params.require(:user).permit(:username,:password)

  end

  def get_user
    if User.exists?(params[:id])
      @user = User.find_by(slug: params[:id])
    else
      flash[:error] = "You cannot go there."
      redirect_to root_path
    end
  end
  def require_same_user
    if current_user != @user
      flash[:error] = "You can't do that!"
      redirect_to root_path
    end
  end
end