class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Comment has been saved!"
      redirect_to @post 
    else
      render 'posts/show'
    end
  end

  def vote
    @user = current_user
    @comment = Comment.find(params[:id])

    old_vote = Vote.remove_old_vote(@comment, @user.id)
    @vote = Vote.new(vote: params[:direction], user_id: @user.id)
    @vote.voteable = @comment
    if @vote.save
      render json: {new_vote: @vote, old_vote: old_vote}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end