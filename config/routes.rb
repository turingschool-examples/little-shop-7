Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [] do
    resource :dashboard, only: :show, to: "merchants#show"
    resource :items, only: :show, to: "items#show"
    resource :invoices, only: :show, to: "invoices#show"
  end

  root "welcome#index"

  namespace :admin do
    get "/dashboard", to: "dashboards#welcome"

    resources :invoices, only: [:index, :show]
    resource :merchants, only: :index
  end
end
