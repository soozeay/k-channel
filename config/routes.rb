Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root "articles#index"
  resources :articles do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
end
