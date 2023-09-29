class LikesController < ApplicationController
  def create
    author = User.find(params[:user_id])
    post = Post.find(params[:post_id])

    like = Like.new(user_id: author.id, post_id: post.id)

    if like.save
      post.update(likes_counter: post.likes.count)
      flash[:success] = 'Like added'

    else
      flash[:error] = 'Oops, something went wrong'
    end

    redirect_to user_post_path(author, post)
  end
end
