Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:index, :new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end
  end
