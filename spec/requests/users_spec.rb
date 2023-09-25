require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET/index' do
    before do
      get users_url
    end

    it 'repond with http success' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/index')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('List of Users')
    end
  end

  # show action
  describe 'GET/show' do
    before do
      get user_url(1)
    end

    it 'repond with http success' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/show')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('Details of a Selected User')
    end
  end
end
