Rails.application.routes.draw do
  root "static_pages#home"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index]
  namespace :admin do
    root "users#index"
    resources :users, except: [:new, :create]
  end
  resources :lessons, except: [:new, :create, :destroy]
  resources :categories do
    resources :lessons, only: [:create]
  end
end
