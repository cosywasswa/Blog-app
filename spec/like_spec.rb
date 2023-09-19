require 'rails_helper'

RSpec.describe Like, type: :Model do
  let(:user) { User.new(name: 'Cosmas', photo: 'www.newpics.com/jpg', bio: 'First son', posts_counter: 0) }
  before { user.save }

  let(:post) do
    Post.new(title: 'greeting', text: 'Nice photos sofar', comments_counter: 0, likes_counter: 0, author_id: user.id)
  end
  before { post.save }

  describe '#update_post_likes_counter' do
    it 'should return correct number of likes' do
      like = Like.create(user_id: user.id, post_id: post.id)
      Like.create(user_id: user.id, post_id: post.id)
      Like.create(user_id: user.id, post_id: post.id)
      Like.create(user_id: user.id, post_id: post.id)

      counter = like.update_post_likes_counter
      expect(counter).to eq(4)
    end
  end
end
