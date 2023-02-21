Rails.application.routes.draw do

  resources :comments
  resources :posts
  root "posts#index"

  get '/user/:id', to: 'users#show', as: 'user'
  get 'profile', to: 'users#show'
  resources :users, only: [:index]
  devise_for :users

  resources :friendships, only: [:create, :destroy, :show]
  resources :friend_requests, only: [:create, :destroy, :show] do 
    post 'accept' => "friend_requests#accept"
    post 'deny' => "friend_requests#deny"
  end
  resources :likes, only: [:create, :destroy]
  
end
