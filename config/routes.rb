Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#home'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

resources :categories, only: [:show] do 
  resources :appointments, only: [:show, :new, :index]
end

resources :categories, only: [:show] do 
  resources :customers, only: [:show, :new, :index]
end

resources :customers, only: [:show] do 
  resources :appointments, only: [:show, :new, :index]
end

resources :customers, only: [:show] do 
  resources :categories, only: [:show, :new, :index]
end




  resources :users 
  resources :customers 
  resources :appointments 
  resources :categories 
end
