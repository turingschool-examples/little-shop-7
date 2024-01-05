Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only: :index
    patch "/merchants/:id", to: "merchants#update", as: :update_merchant
  end

  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:id/dashboard", to: "merchants#show"

end
