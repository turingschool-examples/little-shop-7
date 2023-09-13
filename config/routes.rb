Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :admin do
    get "/", to: "admin#welcome"
  end

  # namespace :merchant do
  #   get "/:merchant_id/"
  # end
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
end
