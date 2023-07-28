Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show, :update]
  end
# namespace :dashboard do 

  resources :merchants, only: :show do
    # resources :dashboard, only: :index, controller: "merchants#show"
    get "/dashboard", to: "merchants#show"
    # member do
    #   get "dashboard"
    # end

    resources :items, only: :index

    resources :invoices, only: :index
  end
end
# end

