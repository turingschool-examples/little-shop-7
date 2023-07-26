Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :admin, controller: 'admin/dashboard', only: [:index]

  # Route for Merchants under Admin
  namespace :admin, as: 'admin_merchants' do
    resources :merchants, only: [:index,:show]
  end





end
