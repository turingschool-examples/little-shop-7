Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :merchants, only: :index do 
    resources :dashboard, only: [:index], controller: "merchant/dashboard"
    resources :items, only: [:index, :show], controller: "merchant/items"
    resources :invoices, only: [:index, :show], controller: "merchant/invoices"
  end

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard
    resources :merchants, only: :index
    patch "/merchants/:id", to: "merchants#update", as: :update_merchant
    resources :invoices, only: [:index, :show]
  end

end
