Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :articles
  resources :users, only: :show
end
