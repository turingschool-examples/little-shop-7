Rails.application.routes.draw do
  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
    resources :dashboard
  end
  get "/merchants/:id/invoices", to: "merchants#invoices"
  
end
