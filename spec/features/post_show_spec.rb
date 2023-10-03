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
    it 'should see title of the post' do
      @posts.each do |post|
          expect(page).to have_content("#{post.title}") 
  end
end
    it 'I can see who wrote the post.' do
        expect(page).to have_content("#{@user_one.name}")
    end
    it 'I can see how many comments it has' do
        @posts.each do |post|
            expect(page).to have_content("Comments:#{post.comments_counter}")
        end
    end
    it 'I can see how many likes a post has' do
        @posts.each do |post|
            expect(page).to have_content("Likes:#{post.likes_counter}")
        end
    end
    
    it 'I can see the username of each commentor' do
        @posts.each do |post|
            post.recent_comments.each do |comment|
              expect(page).to have_content(comment.user.name)
            end
          end
    end
    it 'I can see the comment each commentor left.' do
        @posts.each do |post|
            post.recent_comments.each do |comment|
              expect(page).to have_content(comment.user.text)
            end
          end
    end
end