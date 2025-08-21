# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'users'
  }
  root 'products#index'

  resources :products, only: %i[index]

  resources :users, only: %i[new create]

  resources :carts, only: %i[index create destroy] do
    member do
      patch :update_quantity
    end
  end

  resource :shopping_cart, controller: 'carts', only: [:show]
  get '/dashboard', to: 'products#new', as: :dashboard

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :orders, only: %i[index create]

  namespace :admin do
    resources :orders, only: %i[index update]
    resources :products, only: %i[new create destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        delete '/', action: :destroy, on: :collection
      end

      resources :sessions, only: %i[create] do
        delete '/', action: :destroy, on: :collection
      end

      resources :products, only: %i[index]

      resources :carts, only: %i[index create destroy] do
        member do
          patch :update_quantity
        end
      end

      resources :orders, only: %i[index create]

      namespace :admin do
        resources :users, only: %i[index]
        resources :products, only: %i[create destroy]
        resources :orders, only: %i[index update]
      end
    end
  end
end
