Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "application#welcome"

  get "/merchants/:id/dashboard", to: "merchants#show"

  get "/merchants/:id/items", to: "merchants/items#index"
  get "/merchants/:id/items/new", to: "merchants/items#new"
  post "/merchants/:id/items", to: "merchants/items#create"
  get "/merchants/:id/items/:id", to: "merchants/items#show"
  get "/merchants/:id/items/:id/edit", to: "merchants/items#edit"
  patch "/merchants/:id/items/:id", to: "merchants/items#update"

  get "/merchants/:id/invoices", to: "merchants/invoices#index"
  get "/merchants/:id/invoices/:id", to: "merchants/invoices#show"

  patch "/invoice_items/:id", to: "invoice_items#update"

  get "/admin", to: "admin/dashboards#welcome"

  # get "/admin/merchants", to: "admin/merchants#index"
  # get "/admin/merchants/new", to: "admin/merchants#new"
  # post "/admin/merchants", to: "admin/merchants#create"
  # get "/admin/merchants/:id", to: "admin/merchants#show"
  # get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  # patch "/admin/merchants/:id", to: "admin/merchants#update"

  # get "/admin/invoices", to: "admin/invoices#index"
  # get "/admin/invoices/:id", to: "admin/invoices#show"
  # patch "/admin/invoices/:id", to: "admin/invoices#update"
















  namespace :admin do
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
































end
