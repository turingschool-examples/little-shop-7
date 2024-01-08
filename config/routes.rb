Rails.application.routes.draw do

namespace :admin do
  root to: "dashboard#index"
  resources :merchants, only:[:index, :show]
  resources :invoices, only: [:index, :show]
end 

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
  end
  get "/merchants/:merchant_id/invoices", to: "invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "invoices#show"
end
