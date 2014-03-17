SampleApp::Application.routes.draw do
  resources :paths
  match '/listes/massnew',  to: 'listes#massnew',            via: 'get'

  resources :changes
  resources :listes
  resources :users
  resources :groups #,        only: [:new, :create, :edit, :destroy, :index]
  resources :sessions,      only: [:new, :create, :destroy]
  root to: 'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
end
