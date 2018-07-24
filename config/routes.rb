Rails.application.routes.draw do
  resources :restaurants
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :restaurants
  root 'restaurants#index'
end
