Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, only:[:index, :show, :new, :create]
  resources :cart, except: [:index, :show]
end
