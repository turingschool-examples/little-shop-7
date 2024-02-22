Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [] do
    resources :dashboard, only: [:show]
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index]
  end

  namespace :admin do
    get "/", to: "dashboards#index"
    resources :merchants, only: :index
    resources :invoices, only: :index
  end
end
