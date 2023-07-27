Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
