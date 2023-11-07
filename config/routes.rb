Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [] do
    resources :dashboard, only: :index, controller: 'merchants', action: 'show'
    resources :items, on: :member, only: [:index, :new, :create, :update], controller: "merchant_items" 
    # resources :invoices, only: [:index, :show], controller: "merchant_items"
  end 
  # get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  # get "/merchants/:merchant_id/items", to: "merchant_items#index"
  # get "/merchants/:merchant_id/items/new", to: "merchant_items#new"
  # post "/merchants/:merchant_id/items", to: "merchant_items#create"
  # patch "/merchants/:merchant_id/items", to: "merchant_items#update"
  # patch "/merchants/:merchant_id/items/:item_id", to: "merchant_items#update"

  get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant_items#edit"

  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"
  get "/merchants/:merchant_id/invoices/:invoices", to: "merchant_invoices#show"

  namespace :admin do
    get "/", to: "dashboard#index"
    get "/merchants", to: "merchants#index"
    post "/merchants", to: "merchants#create"
    get "/merchants/new", to: "merchants#new"
    get "/merchants/:merchant_id", to: "merchants#show"
    patch "/merchants/:merchant_id", to: "merchants#update"
    get "/merchants/:merchant_id/edit", to: "merchants#edit"

    get "/invoices", to: "invoices#index"
    get "/invoices/:invoice_id", to: "invoices#show", as: "invoice_show"
    patch "/invoices/:invoice_id", to: "invoices#update"

  end

end
