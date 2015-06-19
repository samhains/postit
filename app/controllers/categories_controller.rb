class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:new, :create]
  protect_from_forgery with: :exception
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:notice] = "New Category Saved!"
      redirect_to posts_path
    else
    render 'new'
    end
  end

  def show
    @category = Category.find_by(slug: params[:id ])
    @posts = @category.posts
  
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end