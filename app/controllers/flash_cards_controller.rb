class FlashCardsController < ApplicationController
  before_action :validate_current_user

  def create
    unless deck
      return(
        render json: { status: "failed", error: "unable to find existing deck" }
      )
    end

    new_flash_card =
      deck.flash_cards.create(
        question: params[:question],
        answer: params[:answer]
      )

    if new_flash_card.persisted?
      render json: {
               status: "success",
               message: "new flashcard successfully created."
             }
    end
  end

  private

  def deck
    @deck ||= Deck.find_by(id: params[:deck_id])
  end
end
