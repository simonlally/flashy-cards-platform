class DecksController < ApplicationController
  before_action :validate_current_user
  def index
  end

  def create
    unless params[:name].present?
      return(
        render json: {
                 status: "failed",
                 error: "name is a required param when creating a deck"
               }
      )
    end

    label = params[:label] if params[:label].present?
    deck = current_user.decks.create(name: params[:name], label: label)

    if deck.persisted?
      render json: {
               status: "success",
               message: "Deck #{deck.name} was successfully created",
               deck_id: deck.id
             }
    else
      render json: {
               status: "failed",
               message: "There was an issue creating the deck, try again"
             }
    end
  end

  def edit
  end

  def show
  end
end
