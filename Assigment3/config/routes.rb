Rails.application.routes.draw do

  root 'products#index'

  resources :products, only: [:index, :new, :create, :destroy]

  resources :users, only: [:new, :create]

  resources :carts, only: [:index, :create, :destroy] do
    member do
      patch :update_quantity
    end
  end

  resource :shopping_cart, controller: 'carts', only: [:show]
  get '/dashboard', to: 'products#new', as: :dashboard

  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  # Add any additional routes here
end
