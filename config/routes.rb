Rails.application.routes.draw do
  resources :merchants, only: [] do
    get 'dashboard', on: :member

    resources :items, only: %i[index show edit update] do
      member do
        patch :toggle_status
      end
    end

    resources :invoices, only: %i[index show]
  end
end # rubocop:disable Lint/Syntax
