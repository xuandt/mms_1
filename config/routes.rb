Rails.application.routes.draw do
  resources :members
  resources :sessions, only: [:new, :create, :destroy]

  root  'homepage#home'
  match '/signup',  to: 'members#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do
    resources :members
    resources :sessions, only: [:new, :create, :destroy]
    match "/signin", to: "sessions#new", via: "get"
    match "/signout", to: "sessions#destroy", via: "delete"
  end
end