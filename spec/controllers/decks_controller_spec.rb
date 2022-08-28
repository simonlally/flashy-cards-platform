require "rails_helper"

RSpec.describe DecksController, type: :controller do
  describe "#index" do
    let!(:bob) { create(:user) }
    let(:current_user) { bob }
    let!(:deck_uno) { create(:deck, user: bob) }
    let!(:card) do
      create(
        :flash_card,
        deck: deck_uno,
        question: "which way is up?",
        answer: "its up, silly"
      )
    end
    let!(:second_card) do
      create(
        :flash_card,
        deck: deck_uno,
        question: "pokemon or digimon?",
        answer: "pokemon"
      )
    end

    let!(:dave) { create(:user, email: "daverias@aol.com") }
    let!(:daves_deck) { create(:deck, user: dave) }
    let!(:third_card) do
      create(
        :flash_card,
        deck: daves_deck,
        question: "is a hotdog a sandwhich?",
        answer: "yes"
      )
    end

    before do
      allow_any_instance_of(DecksController).to receive(:current_user) {
        current_user
      }
    end

    it "returns all of the users decks and cards" do
      get :index, params: {}
      parsed_response =
        JSON.parse(response.body).dig("data", "decks", "deck_id_#{deck_uno.id}")

      deck = parsed_response["deck"]
      expect(deck["id"]).to eq deck_uno.id
      expect(deck["name"]).to eq deck_uno.name
      expect(deck["label"]).to eq deck_uno.label
      expect(parsed_response["cards"].first["id"]).to eq card.id
      expect(parsed_response["cards"].last["id"]).to eq second_card.id
    end

    it "only returns records belong to the current_user" do
      get :index, params: {}
    end
  end
end
