Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#home'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/auth/facebook/callback' => 'sessions#facebook'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/appointments/upcoming' => 'appointments#upcoming'

resources :categories 
resources :customers 
resources :users 
resources :appointments 

resources :categories, only: [:show] do 
  resources :appointments, only: [:show, :new, :index]
end

resources :customers, only: [:show] do 
  resources :appointments, only: [:show, :new, :index]
end


end
