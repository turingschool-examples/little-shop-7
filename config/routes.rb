Rails.application.routes.draw do

  namespace :admin do 
    resources :merchants, only: [:index]
  end

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
    # get "/merchants/:merchant_id/invoices", to: "invoices#index"
    # get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchants/invoices#show"
  end
  get "/merchants/:merchant_id/invoices", to: "invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "invoices#show"
end
