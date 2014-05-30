Rails.application.routes.draw do
  resources :members
  resources :sessions, only: [:new, :create, :destroy]
  resources :positions
  
  root  'homepage#home'
  match '/signup',  to: 'members#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do  
    resources :teams
    resources :skills 
    resources :members 
    resources :sessions, only: [:new, :create, :destroy]
    resources :positions 
    match "/monitor", to: "monitor#index", via: "get"
    match "/export", to: "monitor#export", via: "get"
    match "/import", to: "monitor#import", via: "post"
    match "/signin", to: "sessions#new", via: "get"
    match "/signout", to: "sessions#destroy", via: "delete"
  end
end