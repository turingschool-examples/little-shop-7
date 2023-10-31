Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/customers", to: "customers#index"
  get "/invoice_items", to: "invoice_items#index"

  get "/merchants/:merchant_id/dashboard", to: "merchants#show"

  namespace :admin do
    get "/", to: "dashboard#index", as: 'dashboard'
  end
end
