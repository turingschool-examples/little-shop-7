Rails.application.routes.draw do

  namespace :admin do
     root to: "dashboard#index"
    resources :merchants, only:[:index,:show, :edit,:update]
    resources :invoices, only: [:index, :show]
  end  

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"
  resources :merchants do
   resources :dashboard
  end
  get "/merchants/:id/invoices", to: "merchants#invoices"
end
