Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items", to: "merchant_items#index"

  resources :admins, only: :index
  resources :merchant_dashboard, only: [:show]

  namespace :admins do
    resources :merchants, only: [:index, :show, :edit]
  end

end
