Rails.application.routes.draw do
  namespace :admin do
    root to: "dashboard#index"
    resources :merchants, only:[:index, :show, :edit, :update]
    resources :invoices, only:[:index, :show, :edit, :update]
  end 

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
    resources :items, param: :item_id, only: [:index, :show, :update]
    resources :invoice_items, only: [:update]
  end
end
