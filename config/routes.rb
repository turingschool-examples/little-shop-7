Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [] do
    resource :dashboard, only: :show, to: "merchants#show"
    resources :items, controller: "merchants/items", only: [:show, :index, :edit, :update]
    resource :invoices, controller: "merchants/invoices", only: [:show]
  end

  namespace :merchants do
    resources :invoices, only: :show
    resources :items, only: :show
  end
  
  root "welcome#index"

  namespace :admin do
    get "/", to: "dashboards#welcome"

    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show, :edit, :update]
  end
end
