class FlashCardsController < ApplicationController
  before_action :validate_current_user, :check_for_deck

  def create
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

  def edit
    unless card_in_question.present?
      return render json: { status: "failed", error: "no card found" }
    end

    updated_params = {}
    updated_params[:question] = params[:question] if params[:question].present?
    updated_params[:answer] = params[:answer] if params[:answer].present?

    card_to_edit.update(updated_params)
  end

  def destroy
    unless card_in_question.present?
      return render json: { status: "failed", error: "no card found" }
    end

    if card_in_question.destroy
      render json: { status: "success", message: "deletion successful" }
    else
      render json: { status: "failed", message: "something went wrong" }
    end
  end

  private

  def check_for_deck
    unless deck
      return(
        render json: { status: "failed", error: "unable to find existing deck" }
      )
    end
  end

  def card_in_question
    @card_in_question ||= deck.flash_cards.find_by(id: params[:card_id])
  end

  def deck
    @deck ||= current_user.decks.find_by(id: params[:deck_id])
  end
end
