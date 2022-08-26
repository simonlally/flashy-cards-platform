Rails.application.routes.draw do
  get "/ping" => "ping#index"

  post "/users" => "users#create"
  post "/users/login" => "users#new"
end
