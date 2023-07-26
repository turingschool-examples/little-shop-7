Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
# namespace :dashboard do 

  resources :merchants, only: :show do
    # resources :dashboard, only: :index, controller: "merchants"
    member do
      get "dashboard"
    end
  end
end
# end

