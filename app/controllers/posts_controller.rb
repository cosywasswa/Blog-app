class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @posts }
    end
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
      @user.increment!(:posts_counter)
      redirect_to user_post_url(@user, @post)

    else
      flash.now[:error] = 'Oops, something went wrong'
      redirect_to new_user_post_url
    end
  end

  def destroy
    post = Post.find(params[:id])
    authorize! :destroy, post
    if post.destroy
      flash.now[:success] = 'Post was successfully deleted'
    else
      puts "Couldn't delete post"
      flash.now[:error] = 'Oops. Could not delete the post'
    end
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
