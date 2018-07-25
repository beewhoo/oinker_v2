Rails.application.routes.draw do

  resources :events
  resources :restaurants
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :restaurants
  root 'restaurants#index'

  get '/oinker', to: 'welcome#homepage'
  get '/oinker/carousel', to: 'welcome#carousel'
  get '/oinker/choice', to: 'welcome#res_ev_choice'
  get '/oinker/date_choice', to: 'welcome#date_choice'
  get '/oinker/budget_choice', to: 'welcome#budget_choice'
  get '/oinker/location_choice', to: 'welcome#location_choice'
  get '/oinker/party_size', to: 'welcome#party_size'
  get '/oinker/categories', to: 'welcome#categories'
end
