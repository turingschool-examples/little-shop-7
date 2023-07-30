Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items", to: "merchants#index"
  get "/merchants/:merchant_id/items/:items_id", to: "merchants/items#show"
  get "/merchants/:merchant_id/items/:item_id/", to: "merchants/items#edit"
  patch "/merchants/:merchant_id/items/:item_id/", to: "merchants/items#update"

  resources :admins, only: :index
  resources :merchant_dashboard, only: [:show]

  namespace :admins do
    resources :merchants
  end

end
