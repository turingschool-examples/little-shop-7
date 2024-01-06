Rails.application.routes.draw do

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end  

  namespace :admin do 
    resources :merchants, only: [:index]
  end

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
    resources :dashboard
  end
  get "/merchants/:id/invoices", to: "merchants#invoices"
end
