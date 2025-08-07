Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %i[index new create destroy]

  get '/dashboard', to: 'products#new', as: :dashboard

  get 'up' => 'rails/health#show', as: :rails_health_check
end
