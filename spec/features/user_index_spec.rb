require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
  before(:each) do
    @users = [
      @user1 = User.create(
        name: 'Cosmas',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Web developer from Uganda',
        posts_counter: 0
      ),
      @user2 = User.create(
        name: 'Martin',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Software developer.',
        posts_counter: 0
      )
    ]
    visit users_url
  end
  describe '#indexpage' do
    it 'can see the username of all other users.' do
      expect(page).to have_content(@users[0].name)
      expect(page).to have_content(@users[1].name)
    end

    it 'I can see the profile picture for each user.' do
      @users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end

    it 'I can see the number of posts each user has written.' do
      @users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end

    it 'When I click on a user, I am redirected to that user show page.' do
      click_link(@users[0].name)
      expect(page).to have_current_path(user_path(@users[0].id))
    end
  end
end
