class PostsController < ApplicationController
  before_action :find_post_by_id, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create] 
  before_action :require_creator, only: [:edit, :update ]

  def index
    @posts = Post.all.sort_by{|post| post.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @user = current_user
    @post.creator = @user

    if @post.save
      flash[:notice] = "Post Has Been Saved"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
  
    if @post.update(post_params)
      flash[:notice] = "Post Updated!"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def vote
    @user = current_user
    old_vote = Vote.remove_old_vote(@post, @user.id)
    @vote = Vote.new(vote: params[:direction], user_id: @user.id)
    @vote.voteable = @post
    if @vote.save
      render json: {new_vote: @vote, old_vote: old_vote}
    end
  end

  def require_creator
    access_denied unless is_creator?(@post) || is_admin?
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :user_id, :category_ids => [])
  end


  def find_post_by_id
    @post = Post.find_by(slug: params[:id])
  end
end
