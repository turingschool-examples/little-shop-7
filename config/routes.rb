Rails.application.routes.draw do

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end  

end
