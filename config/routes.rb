Rails.application.routes.draw do
  root to: 'users#index'
  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/new', to: 'posts#new', as: 'new_post'
  post '/users/:user_id/posts', to: 'posts#create', as: 'create_post'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  resources :users, only: [] do
  resources :posts, only: [] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:new, :create]
  end
end
end
