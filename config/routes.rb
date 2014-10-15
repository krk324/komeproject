Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => "users/sessions",
    :registrations => "users/registrations"

  }

  root 'home#index'
  resources :orders, only:[:index, :show, :create, :update]
  resources :carts, except: [:index, :show, :new]
  resources :charges, only:[:new, :create]
  resources :drivers, only:[:index]
end
