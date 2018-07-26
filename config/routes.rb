Rails.application.routes.draw do

  resources :events
  resources :restaurants
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :restaurants
  root 'restaurants#index'

  get '/welcome', to: 'welcome#homepage'
  get '/welcome/carousel', to: 'welcome#carousel'
  get '/welcome/choice', to: 'welcome#res_ev_choice'
  get '/welcome/date_choice', to: 'welcome#date_choice'
  get '/welcome/budget_choice', to: 'welcome#budget_choice'
  get '/welcome/res_ev_choice', to: 'welcome#res_ev_choice'
  get '/welcome/location_choice', to: 'welcome#location_choice'
  get '/welcome/party_size', to: 'welcome#party_size'
  get '/welcome/categories', to: 'welcome#categories'
end
