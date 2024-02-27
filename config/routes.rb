Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [] do
    resource :dashboard, only: [:show]
    resources :items, only: [:index,:show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  namespace :admin do
    get "/", to: "dashboards#index"
<<<<<<< HEAD
    resources :merchants, only: [:index, :show, :new, :create]
=======
    resources :merchants, only: [:index, :show, :edit, :update]
>>>>>>> 0320c0772db02ddf7eb9fe92beb3088e2c4c3688
    resources :invoices, only: [:index, :show]
  end
end
