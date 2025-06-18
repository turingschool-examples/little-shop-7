Rails.application.routes.draw do
  resources :merchants, only: [] do
    get 'dashboard', on: :member
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
end
