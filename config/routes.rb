Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :admin, only: :index

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
  end

  resources :merchants do 
    # resources :dashboard, as: "merchant_dashboard"
    member { get "dashboard" }
    resources :items, controller: 'merchant_items', only: [:index, :show]
  end
  

  resources :invoices, controller: "merchant_invoices"

end
