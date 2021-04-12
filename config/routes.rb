Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root "articles#index"
  resources :articles do
    collection do
      get 'search'
    end
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]

end
