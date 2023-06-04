Rails.application.routes.draw do
  
  get "/admin", to: "admin/dashboards#dashboard" 
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/invoices", to: "admin/invoices#index"
  post "admin/merchants/:id", to: "admin/merchants#create"
  get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  get "/admin/merchants/:id", to: "admin/merchants#show"
  patch "/admin/merchants/:id", to: "admin/merchants#update"
  get "/admin/invoices/:id", to: "admin/invoices#show"

  get "/merchants/:id/dashboard", to: "merchants#show"
  get "/merchants/:id/items", to: "merchants/items#index"
  get "/merchants/:id/invoices", to: "merchants/invoices#index"
  get "merchants/:id/invoices/:id", to: "merchants/invoices#show"

end
