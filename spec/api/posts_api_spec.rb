require 'swagger_helper'

describe 'Posts API' do
  path '/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :integer, required: true, description: 'User ID'
    get 'Retrieve all the posts of a user' do
      tags 'Posts'
      produces 'application/json'
      response '200', 'OK' do
        run_test!
      end
    end
  end
end
