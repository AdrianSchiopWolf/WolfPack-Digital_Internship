# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %i[index new create destroy]

  resources :users, only: %i[new create]

  resources :carts, only: %i[index create destroy] do
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

  post '/checkout', to: 'orders#create', as: :checkout

  namespace :admin do
    resources :orders, only: %i[index update]
  end
end
