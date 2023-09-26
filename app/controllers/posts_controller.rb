class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = User.find(params[:user_id])
    @likes = @post.likes.all
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_url(@user, @post)

    else
      flash.now[:error] = 'Oops, something went wrong'
      redirect_to new_post_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
