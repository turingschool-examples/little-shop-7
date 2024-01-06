Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do 
    resources :merchants, only:[:index]
    resources :merchants, only:[:show]


  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  #resources :merchants do
  #  resources :dashboard
  end
end
