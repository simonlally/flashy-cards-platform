Rails.application.routes.draw do
  get "/ping" => "ping#index"

  post "/users" => "users#create"
  post "/users/login" => "users#new"

  post "/decks" => "decks#create"
  post "/deck/:id/cards" => "flash_cards#create"
  post "/deck/:id/card/:id" => "flash_cards#edit"
end
