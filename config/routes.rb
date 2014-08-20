Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, only:[:index, :show, :create]
  resources :carts, except: [:index, :show]
  resources :charges, only:[:new, :create]
end
