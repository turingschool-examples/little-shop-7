Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

get "/merchants/:id/dashboard", to: "merchants#show"





#Admin 

  namespace :admin do 
    get "/", to: "dashboards#welcome"
    resources :merchants
    resources :invoices
  end 
end