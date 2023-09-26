class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(user_id: @post.author_id, post_id: @post.id, id: @post.id)
      @post.update(comments_counter: @post.comments.count)
    else
      redirect_to new_user_post_comment_path(user_id: @post.author_id, post_id: @post.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
