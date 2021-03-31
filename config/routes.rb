Rails.application.routes.draw do
  devise_for :users
  root "tops#index"
   resources :article, only: [:index, :new]
end
