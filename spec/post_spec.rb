require 'rails_helper'

RSpec.describe Post, type: :Model do
  let(:user) { User.new(name: 'Cosmas', photo: 'www.newpics.com/jpg', bio: 'First son', posts_counter: 4) }
  before { user.save }

  let(:post) do
    Post.new(title: 'greeting', text: 'Nice photos sofar', comments_counter: 2, likes_counter: 10, author_id: user.id)
  end
  before { post.save }

  it 'title should be present' do
    post.title = nil
    expect(post).to_not be_valid
  end
  it 'title should not exceede 250 characters' do
    post.title = 'b' * 260
    expect(post).to_not be_valid
  end
  it 'comments_counter should be an integer' do
    post.comments_counter = 'a'
    expect(post).to_not be_valid
  end
  it 'comments_counter should be greater or equal to zero' do
    post.comments_counter = -2
    expect(post).to_not be_valid
  end
  it 'likes_counter should be an integer' do
    post.likes_counter = 'k'
    expect(post).to_not be_valid
  end
  it 'likes_counter should be greater or equal to zero' do
    post.likes_counter = -4
    expect(post).to_not be_valid
  end
  describe '#update_user_posts_counter' do
    it 'should record the posts counter' do
      counter = post.update_user_posts_counter
      expect(counter).to eq(1)
    end
  end
  describe '#recent_comments' do
    it 'it should return 5 recent comments' do
      Comment.create(text: 'hey budy', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy2', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy3', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy4', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy5', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy6', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy7', user_id: user.id, post_id: post.id)
      my_comments = post.recent_comments
      expect(my_comments.length).to eq(5)
    end
    it 'it should return 5 recent comments' do
      Comment.create(text: 'hey budy', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy2', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy3', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy4', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy5', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy6', user_id: user.id, post_id: post.id)
      Comment.create(text: 'hey budy7', user_id: user.id, post_id: post.id)
      my_comments = post.recent_comments
      expect(my_comments.first.text).to eq('hey budy7')
    end
  end
end
