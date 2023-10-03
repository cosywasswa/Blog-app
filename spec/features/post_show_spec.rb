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
        text: 'This is my first post',
        comments_counter: 0,
        likes_counter: 0
      ),
      @post2 = Post.create(
        author: @user_one,
        title: 'Blog2',
        text: 'This is my second post',
        comments_counter: 0,
        likes_counter: 0
      )
    ]
    visit user_posts_url(user_id: @user_one.id)
  end

  describe 'show page' do
    before(:each) do
      visit user_post_path(@user_one, @post1)
    end
    it 'should see title of the post' do
      expect(page).to have_content(@post1.title.to_s)
    end
    it 'I can see who wrote the post.' do
      expect(page).to have_content(@user_one.name.to_s)
    end
    it 'I can see how many comments it has' do
      expect(page).to have_content(@post1.comments_counter)
    end
    it 'I can see how many likes a post has' do
      expect(page).to have_content("Likes:#{@post1.likes_counter}")
    end

    it 'should see body of the post' do
      expect(page).to have_content(@post1.text.to_s)
    end

    it 'I can see the username of each commentor' do
      @post1.recent_comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end
    it 'I can see the comment each commentor left.' do
      @post1.recent_comments.each do |comment|
        expect(page).to have_content(comment.user.text)
      end
    end
  end
end
