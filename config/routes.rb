Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :admin, only: :index
  
  #Merchant

  resources :merchants, only: [:show]do 
    resources :dashboard, only: :index
  end
  
  
  
  
  
  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: :index
    resources :invoives, only: :index
  end
end
