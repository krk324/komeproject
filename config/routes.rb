Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  resources :orders, only:[:index, :show, :create]
  resources :carts, except: [:index, :show]
  resources :charges, only:[:new, :create]
end
