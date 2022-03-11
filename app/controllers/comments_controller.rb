class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author_id = @post.id
    @comment.post_id = params[:post_id]

    @comment.update_comments_counter
    if @comment.save
      redirect_to user_post_path(@post.id, Post.find(params[:post_id]))
    else
      flash.now[:error] = 'Failed to create comment'
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
