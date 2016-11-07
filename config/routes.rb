Rails.application.routes.draw do

  root 'articles#index'
  resources :users
  resources :sessions, only: [:create]
  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  resources :articles
end
