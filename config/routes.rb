Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [] do
    resources :dashboard, only: :index, controller: 'merchants', action: 'show'
    resources :items, on: :member, only: [:index, :new, :create, :update, :show, :edit], controller: "merchant_items" 
    resources :invoices, only: [:index, :show], controller: "merchant_invoices"
  end 

  patch "/merchants/:merchant_id/invoices/:invoices", to: "merchant_invoice_items#update"

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
