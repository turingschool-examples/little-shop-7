Rails.application.routes.draw do

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end  


  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do 
    resources :merchants, only: [:index]

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
    resources :dashboard
  end
end
