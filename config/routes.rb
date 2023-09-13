Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/admin", to: "admin_application#welcome"

  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/invoices", to: "admin/invoices#index"
end
