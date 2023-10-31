Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants do
    resources :items, only: [:index] do

    end
    resources :invoices, only: [:index] do

    end
    member do
      get "dashboard"
    end
  end
end
