Rails.application.routes.draw do
  get "admin/user"
  resources :skills
  resources :projects
  resources :positions
  resources :teams
  resources :members
  resources :sessions, only: [:new, :create, :destroy]

  root  'homepage#home'
  match '/signup',  to: 'members#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    resources :members
    resources :projects
    resources :positions
    resources :teams
    match "/signin", to: "sessions#new", via: "get"
    match "/signout", to: "sessions#destroy", via: "delete"
  end

end