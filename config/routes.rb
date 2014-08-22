Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'home#index'
  resources :orders, only:[:index, :show, :create]
  resources :carts, except: [:index, :show]
  resources :charges, only:[:new, :create]
end
