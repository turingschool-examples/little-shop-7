Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "application#welcome"

  get "/merchants/:id/dashboard", to: "merchants#show"
  get "merchants/:id/items", to: "merchants/items#index"
  get "merchants/:id/invoices", to: "merchants/invoices#index"

  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/merchants/:id", to: "admin/merchants#show"

  get "/admin/invoices", to: "admin/invoices#index"
  get "/admin/invoices/:id", to: "admin/invoices#show"
end
