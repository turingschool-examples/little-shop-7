Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Merchant Dashboard
  
resources :merchants, only: [:show] do
    resources :dashboard, only: [:index], controller: 'merchants/dashboard'
  end

  resources :merchants, only: [:show] do
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
  end
end

