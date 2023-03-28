Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/user/register', to: "users#register"
  post '/user/login', to: "users#login"
  get '/user/login/check', to: "users#check_login_status"
  delete '/user/logout', to: "users#logout"

  # todos
  # resources :todos, only: [:create]
  post '/todos/create', to: "todos#create"
  put '/todos/:id', to: "todos#update"
  delete '/todos/:id', to: "todos#destroy"
  get '/todos', to: "todos#index"

  get '/verify', to: "application#verify_auth"
end
