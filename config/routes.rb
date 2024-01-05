Rails.application.routes.draw do
  get "/merchants/:id/invoices", to: "merchants#invoices"
end
