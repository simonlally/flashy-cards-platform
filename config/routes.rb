Rails.application.routes.draw do
  get "/ping" => "ping#index"

  post "/users" => "users#create"
  post "/users/login" => "users#new"

  get "/decks" => "decks#index"
  get "/deck/:id" => "decks#show"
  get "/deck/:id/card/:id" => "flash_cards#show"
  post "/decks" => "decks#create"
  post "/decks/:id" => "decks#edit"
  post "/deck/:id/cards" => "flash_cards#create"
  post "/deck/:id/card/:id" => "flash_cards#edit"
  delete "/deck/:id" => "decks#destroy"
  delete "/deck/:id/card/:id" => "flash_cards#destroy"
end
