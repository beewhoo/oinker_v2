
Rails.application.routes.draw do

  resources :events
  resources :restaurants
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :restaurants
  root 'welcome#homepage'

  get '/welcome', to: 'welcome#homepage'
  get '/welcome/choice', to: 'welcome#select_choices'
  get '/welcome/trending', to: 'welcome#trending'
  get '/date_plan', to: 'date_plan#plan'
  get '/user_plan', to: 'date_plan#user_plan'
end
