require 'rails_helper'

RSpec.describe Comment, type: :Model do
  let(:user) { User.new(name: 'Cosmas', photo: 'www.newpics.com/jpg', bio: 'First son', posts_counter: 4) }
  before { user.save }

  let(:post) do
    Post.new(title: 'greeting', text: 'Nice photos sofar', comments_counter: 2, likes_counter: 10, author_id: user.id)
  end
  before { post.save }

  let(:comment) { Comment.new(text: 'hey brother', user_id: user.id, post_id: post.id) }
  before { comment.save }

  describe '#update_post_comments_counter' do
    it 'should return correct number of comments' do
      counter = comment.update_post_comments_counter
      expect(counter).to eq(1)
    end
    it 'should return two comments after adding a second comment' do
      Comment.create(text: 'hey here is the second', user_id: user.id, post_id: post.id)
      counter = comment.update_post_comments_counter
      expect(counter).to eq(2)
    end
  end
end
