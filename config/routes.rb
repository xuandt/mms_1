Rails.application.routes.draw do
  resources :members 
  resources :sessions, only: [:new, :create, :destroy]
  resources :positions
  
  root  'homepage#home'
  match '/signup',  to: 'members#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do
    resources :teams do
    collection { post :import }
    end
    resources :skills do
    collection { post :import }
    end
    resources :projects do
    collection { post :import }
    end
    resources :members do
    collection { post :import }
    end
    resources :sessions, only: [:new, :create, :destroy]
    resources :positions do
    collection { post :import }
    end
    match "/monitor", to: "monitor#home", via: "get"
    match "/signin", to: "sessions#new", via: "get"
    match "/signout", to: "sessions#destroy", via: "delete"
  end
end