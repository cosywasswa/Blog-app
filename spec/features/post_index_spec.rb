require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  before(:each) do
    @user_one = User.create(
      id: 1,
      name: 'Cosmas',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Web developer from Uganda',
      posts_counter: 0
    )

    @posts = [
      @post1 = Post.create(
        author: @user_one,
        title: 'Blog1',
        text: 'This is my first post'
      ),
      @post2 = Post.create(
        author: @user_one,
        title: 'Blog2',
        text: 'This is my second post'
      )
    ]
    visit user_posts_url(user_id: @user_one.id)
  end
  describe '#Indexpage' do
    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user_one.photo}']")
    end
    it 'I can see the user username.' do
      expect(page).to have_content(@user_one.name.to_s)
    end
    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content(@user_one.posts_counter.to_s)
    end

    it 'should see title of the post' do
      @posts.each do |post|
        expect(page).to have_content(post.title.to_s)
      end
    end

    it 'should see body of the post' do
      @posts.each do |post|
        expect(page).to have_content(post.text.to_s)
      end
    end

    it 'I can see the first comments on a post.' do
      @posts.each do |post|
        post.recent_comments.each do |comment|
          expect(page).to have_content(comment.user.text)
        end
      end
    end
    it 'I can see how many comments a post has' do
      @posts.each do |post|
        expect(page).to have_content("Comments:#{post.comments_counter}")
      end
    end
    it 'I can see how many likes a post has' do
      @posts.each do |post|
        expect(page).to have_content("Likes:#{post.likes_counter}")
      end
    end
  end
  describe 'GET show/page' do
    it 'When I click on a post, I am redirected to that postshow page.' do
      visit user_posts_url(user_id: @user_one.id)
      post = @posts.first
      click_link(post.id)
      expect(page).to have_current_path(user_post_path(@user_one.id, post.id))
    end
  end
end
