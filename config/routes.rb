Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants, only: [:index, :show], controller: "merchants"
  end

  namespace :merchants do
    resources :items, only: [:index]
  end
end
