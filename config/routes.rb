Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :registrations => "users/registrations" , :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  resources :orders, only:[:index, :show, :create, :update]
  resources :carts, except: [:index, :show]
  resources :charges, only:[:new, :create]
  resources :drivers, only:[:index]
end
