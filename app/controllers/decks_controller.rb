class DecksController < ApplicationController
  before_action :validate_current_user
  def index
    data = {}
    current_user.decks.map do |deck|
      data["deck_id_#{deck.id}"] = { deck: deck, cards: deck.flash_cards }
    end

    render json: { data: { decks: data } }
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
    unless deck
      return(
        render json: { status: "failed", error: "couldn't find deck to edit" }
      )
    end

    updated_params = {}
    updated_params[:name] = params[:name] if params[:name].present?
    updated_params[:label] = params[:label] if params[:label].present?

    if deck.update(updated_params)
      updated_deck = deck.reload
      render json: {
               status: "success",
               data: {
                 deck: updated_deck,
                 cards: updated_deck.flash_cards
               }
             }
    else
      render json: { status: "failed", error: "something went wrong" }
    end
  end

  def show
    unless deck
      return(
        render json: { status: "failed", error: "couldn't find deck to show" }
      )
    end

    render json: { data: { deck: deck, cards: deck.flash_cards } }
  end

  def destroy
    unless deck
      return(
        render json: { status: "failed", error: "couldn't find deck to delete" }
      )
    end

    if deck.destroy
      render json: {
               status: "success",
               message: "Deck #{deck.name} was successfully deleted."
             }
    else
      render json: { status: "failure", message: "deletion failed. try again" }
    end
  end

  private

  def deck
    @deck ||= current_user.decks.find_by(id: params[:deck_id])
  end
end
