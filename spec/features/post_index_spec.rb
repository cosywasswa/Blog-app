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
    describe "#Indexpage" do
        it 'can see the user profile picture.' do
            expect(page).to have_css("img[src='#{@user_one.photo}']")
        end
        it 'I can see the user username.' do
            expect(page).to have_content("#{@user_one.name}")
        end
        it 'I can see the number of posts the user has written.' do
            expect(page).to have_content("#{@user_one.posts_counter}")
        end
        it 'I can see the user blog text' do
            @posts.each do |post|
                expect(page).to have_content("#{post.text}")
            end
        end
        it 'I can see the first comments on a post' do
            @posts.each do |post|
                expect(page).to have_content("Comments:#{post.comments_counter}")
            end
        end
        it 'I can see how many likes a post has' do
            @posts.each do |post|
                expect(page).to have_content("Comments:#{post.likes_counter}")
            end
        end
    end
end