Rails.application.routes.draw do
  namespace :admin do
    root to: "dashboard#index"
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index]
  end

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
   resources :dashboard
  end
  get "/merchants/:id/invoices", to: "merchants#invoices"
end
