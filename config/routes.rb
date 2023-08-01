Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  # get "/merchants/:merchant_id/items", to: "merchants/items#index"
  # get "/merchants/:merchant_id/items/:items_id", to: "merchants/items#show"
  # get "/merchants/:merchant_id/items/:item_id/edit", to: "merchants/items#edit"
  # patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update" 
  # patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update_status", as: :update_status_merchant_item



  resources :merchants do #, only: :index do
    resources :items, controller: "merchants/items" #, only: [:index, :show, :new, :create, :edit, :update]
    resources :dashboard #, only: [:index, :show]
  end


  namespace :merchants do
    resources :items
  end

  resources :admins, only: :index

  resources :merchant_dashboard, only: [:show]
  
  # namespace :admins do
  #   resources :merchants do
  #     member do
  #     patch :toggle_status
  #     end
  #   end
  # end
  
  resources :admin, only: :index, controller: "admins"
  scope '/admin', module: 'admins'  do
    resources :merchants, as: "admin_merchants" do
      member do
        patch :toggle_status
      end
    end
  end

end
