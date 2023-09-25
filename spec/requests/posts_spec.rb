require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET/index' do
    before do
      get user_posts_path(user_id: 1)
    end

    it 'repond with http success' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/index')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('A list of all posts of a given user')
    end
  end

  # show action

  describe 'GET/show' do
    before do
      get user_post_url(user_id: 1, id: 1)
    end

    it 'repond with http success' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/show')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('Details for a selected Post')
    end
  end
end
