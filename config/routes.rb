Rails.application.routes.draw do
  root 'statics#home'
  get "/about", to:'statics#about'
  get "/feed", to:'statics#feed'
   
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

 get "/login", to: "sessions#new"
 post "/login", to: "sessions#create"
 get "/logout", to: "sessions#destroy"


  resources :sessions
  resources :users 
  resources :posts do
      post :pay, on: :member
  end
end
