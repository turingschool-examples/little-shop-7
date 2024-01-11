Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: :index do
    resources :dashboard, only: [:index], controller: "merchant/dashboard"
    resources :items, only: [:index, :show, :edit, :update], controller: "merchant/items"
    resources :invoices, only: [:index, :show], controller: "merchant/invoices"
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    patch "/merchants/:id", to: "merchants#update", as: :update_merchant
    patch 'merchants/:id/update_info', to: 'merchants#update_info', as: 'merchant_update_info'
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update] 
    resources :invoices, only: [:index, :show, :update]
  end

  # quin is keeping these in incase resources fails, will delete after making sure it works
  #get   "/merchants/:merchant_id/items",                to: "merchant_items#index"
  #get   "/merchants/:merchant_id/items/:item_id",       to: "items#show"
  #patch "/merchants/:merchant_id/items/:item_id",       to: "items#update"
  #get   "/merchants/:merchant_id/items/:item_id/edit",  to: "items#edit"
end
