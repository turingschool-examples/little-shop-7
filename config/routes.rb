Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"

  namespace :admin, path: '/admin' do
    get '', to: 'dashboard#index', as: 'dashboard'
    resources :merchants, only: [:index, :show, :edit, :update]
  end
end
