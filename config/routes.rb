Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :merchants, only: [] do
    member do
      get 'dashboard', to: 'merchants#show'
    end

    resources :items, controller: 'merchant_items', only: [:index, :new, :show, :edit, :update, :create]
    resources :invoices, controller:'merchant_invoices', only: [:index]
  end

#Admin
  namespace :admin do
    root to: "dashboard#index"
    resources :merchants
    resources :invoices
  end
end
