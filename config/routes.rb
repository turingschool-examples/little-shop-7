Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :admin do
    get "/", to: "dashboards#welcome"
    get "/invoices", to: "invoices#index"
    get "/invoices/:id", to: "invoices#show"
  end

  # namespace :merchant do
  #   get "/:merchant_id/"
  # end
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/admin/merchants", to: "admin/merchants#index"
end
# namespace: admin do 
#   resources: merchants, only [index] 
# end