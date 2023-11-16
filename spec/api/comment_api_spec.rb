require 'swagger_helper'

describe 'Comments API' do
  path '/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :integer, required: true, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :integer, required: true, description: 'Post ID'
    get 'Retrieve all comments of a post' do
      tags 'Comments'
      produces 'application/json'
      response '200', 'OK' do
        run_test!
      end
    end
    post 'Create a new comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }
      response '201', 'Created' do
        let(:comment) { { text: 'string' } }
        run_test!
      end
    end
  end
end
