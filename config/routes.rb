Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items", to: "merchants#index", as: :merchant_items
  get "/merchants/:merchant_id/items/:items_id", to: "merchants/items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchants/items#edit"
  patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update" 
  patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update_status", as: :update_status_merchant_item

  namespace :merchants do
    resources :items
  end

  resources :admins, only: :index
  resources :merchant_dashboard, only: [:show]

  namespace :admins do
    resources :merchants
  end

end
