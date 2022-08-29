Rails.application.routes.draw do
  get "/ping" => "ping#index"

  post "/users" => "users#create"
  post "/users/login" => "users#new"

  get "/decks" => "decks#index"
  get "/deck/:deck_id" => "decks#show"
  get "/deck/:deck_id/card/:card_id" => "flash_cards#show"
  post "/decks" => "decks#create"
  post "/decks/:deck_id" => "decks#edit"
  post "/deck/:deck_id/cards" => "flash_cards#create"
  post "/deck/:deck_id/card/:card_id" => "flash_cards#edit"
  delete "/deck/:deck_id" => "decks#destroy"
  delete "/deck/:deck_id/card/:card_id" => "flash_cards#destroy"
end
