Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/merchants/:id/dashboard", to: "merchants#show"
  # get "/merchants/:id/items", to: "merchant_items#index"
  resources :merchants, only: [] do
    member do
      get 'dashboard', to: 'merchants#show'
    end
    # I added a MerchantItems controller for User Story 6:
    resources :items, controller: 'merchant_items', only: [:index, :show, :edit, :update]
    #(when we need items index page, we can add this)= resources :items, only: [:index]
  end
  # patch "/merchants/:merchant_id/items/:id", to: "merchant_items#update" i think we can delete this

get "/merchants/:id/dashboard", to: "merchants#show"
#Admin
  namespace :admin do
    root to: "dashboard#index"
    resources :merchants
    resources :invoices
  end
end
