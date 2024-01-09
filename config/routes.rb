Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard

    resources :merchants, only: [:index, :new, :create, :show]
    patch "/merchants/:id", to: "merchants#update", as: :update_merchant

    resources :invoices, only: :index
  end

  get "/merchants/:id/dashboard",               to: "merchants#show"
  get "/merchants/:merchant_id/items",          to: "merchant_items#index"
  get "/merchants/:merchant_id/items/:item_id", to: "items#show"

end
