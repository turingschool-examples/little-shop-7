Rails.application.routes.draw do
  resources :merchants, only: [] do
    get 'dashboard', on: :member
  end
end
