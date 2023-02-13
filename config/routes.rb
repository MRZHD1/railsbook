Rails.application.routes.draw do
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"  

  resources :friendships, only: [:create, :destroy, :show]
  resources :friend_requests, only: [:create, :destroy, :show]

  resources :users, only: [:index]
end
