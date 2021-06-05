Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # ActionCable
  mount ActionCable.server => '/cable'

  root "articles#index"
  resources :articles do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :messages, only: [:create, :destroy] do
    member do
      get 'correction'
      post 'correct'
    end
  end
  resources :rooms, only: [:create, :show, :index]

  # ゲストログイン機能
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
