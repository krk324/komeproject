Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :registrations => "users/registrations" , :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  resources :orders, only:[:index, :show, :create]
  resources :carts, except: [:index, :show]
  resources :charges, only:[:new, :create]
end
