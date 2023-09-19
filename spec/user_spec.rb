require 'rails_helper'

RSpec.describe User, type: :Model do
  let(:user) { User.new(name: 'Cosmas', photo: 'www.newpics.com/jpg', bio: 'First son', posts_counter: 4) }
  before { user.save }

  it 'name should be present' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'posts_counter must be an integer' do
    user.posts_counter = 'a'
    expect(user).to_not be_valid
  end
  it 'posts_counter should be greated than or equal to zero' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end
  describe '#recent_posts' do
    it 'should have correct number of posts' do
      Post.create(title: 'Post 1', text: 'Content 1', comments_counter: 0, likes_counter: 0, author_id: user.id)
      Post.create(title: 'Post 2', text: 'Content 2', comments_counter: 0, likes_counter: 0, author_id: user.id)
      Post.create(title: 'Post 3', text: 'Content 3', comments_counter: 0, likes_counter: 0, author_id: user.id)
      my_posts = user.recent_posts
      expect(my_posts.length).to eq(3)
    end
  end
end
