class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(user_id: @post.author_id, post_id: @post.id, id: @post.id) }
        format.json { render json: { message: 'Comment Added' }, status: :created }
      end
      @post.update(comments_counter: @post.comments.count)
    else
      respond_to do |format|
        format.html { redirect_to new_user_post_comment_path(user_id: @post.author_id, post_id: @post.id) }
        format.json { render json: { message: 'Comment Not Add' }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    authorize! :destroy, comment
    if comment.destroy
      flash.now[:success] = 'Comment was successfully deleted'
    else
      puts "Couldn't delete post"
      flash.now[:error] = 'Oops. Could not delete the Comment'
    end
    redirect_to user_post_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
