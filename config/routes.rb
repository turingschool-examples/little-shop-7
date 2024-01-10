Rails.application.routes.draw do

  namespace :admin do
     root to: "dashboard#index"
    resources :merchants, only:[:index, :show, :edit, :update]
    resources :invoices, only:[:index, :show, :edit, :update]
  end  

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
    resources :items, only: [:index, :show]
  end

end
