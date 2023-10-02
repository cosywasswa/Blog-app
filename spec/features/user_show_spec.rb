require 'rails_helper'

RSpec.describe 'users#show page', type: :feature do
before(:each) do
            @user1 = User.create(
              name: 'Cosmas',
              photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
              bio: 'Web developer from Uganda',
              posts_counter: 0
            )

            @user2 = User.create(
              name: 'Martin',
              photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
              bio: 'Software developer.',
              posts_counter: 0
            )
  
    visit users_url
end
describe 'show page content' do
  before(:each) do
     visit user_path(@user1)
  end

    it 'can see the user profile picture.' do
        expect(page).to have_css("img[src='#{@user1.photo}']")
    end

    it 'can see the user username' do
        expect(page).to have_content("#{@user1.name}")
    end

    it 'I can see the number of posts the user has written.' do
        expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end

    it 'I can see the user bio.' do
        expect(page).to have_content("#{@user1.bio}")
    end

    it 'I can see the user first 3 posts.' do
        @user1.recent_posts.each do |post|
            expect(page).to have_content(post.title)
    end
end

it 'can see a button to view all user posts' do
    expect(page).to have_selector('button', text: 'See all posts')
  end

end
end