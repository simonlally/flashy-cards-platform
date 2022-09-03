require "rails_helper"

RSpec.describe DecksController, type: :controller do
  let!(:bob) { create(:user) }
  let(:current_user) { bob }
  let!(:deck_uno) { create(:deck, user: bob, name: "garbage") }
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

  describe "#index" do
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
      allow_any_instance_of(DecksController).to receive(:current_user) { dave }
      get :index, params: {}

      parsed_response =
        JSON.parse(response.body).dig(
          "data",
          "decks",
          "deck_id_#{daves_deck.id}"
        )
      deck = parsed_response["deck"]
      expect(deck["id"]).to eq daves_deck.id
      expect(deck["id"]).to_not eq deck_uno.id
      expect(parsed_response["cards"].first["id"]).to eq third_card.id
      expect(parsed_response["cards"].first["deck_id"]).to eq daves_deck.id
    end
  end

  describe "#create" do
    let!(:bill) { create(:user, email: "bill@billsworld.org") }

    context "when name is present in params" do
      it "returns the correct response body" do
        allow_any_instance_of(DecksController).to receive(:current_user) {
          bill
        }
        expect(bill.decks.count).to eq 0
        post :create, params: { name: "Sprinkles" }
        new_deck = bill.decks.first
        expect(bill.decks.count).to eq 1
        expect(new_deck.name).to eq "Sprinkles"
        expect(JSON.parse(response.body)).to eq(
          {
            "status" => 200,
            "message" => "Deck #{new_deck.name} was successfully created",
            "deck_id" => new_deck.id
          }
        )
      end

      it "creats a new deck" do
        expect { post :create, params: { name: "sprinkles" } }.to change(
          Deck,
          :count
        ).by(1)
      end
    end

    context "when name is not present in params" do
      it "returns an error" do
        post :create, params: {}
        expect(
          JSON.parse(response.body)["error"]
        ).to eq "name is a required param when creating a deck"
      end

      it "does not create a new deck" do
        expect(Deck).to_not receive(:create)
        expect { post :create, params: {} }.to_not change(Deck, :count)
      end
    end
  end

  describe "#show" do
    it "shows the deck and cards that correspond with the id in params" do
      get :show, params: { id: deck_uno.id, deck_id: deck_uno.id }

      data = JSON.parse(response.body)["data"]

      expect(data["deck"]["id"]).to eq deck_uno.id
      expect(data["deck"]["name"]).to eq deck_uno.name
      expect(data["cards"].first["id"]).to eq card.id
      expect(data["cards"].second["id"]).to eq second_card.id
    end
  end

  describe "#edit" do
    it "updates the name of the deck" do
      expect(deck_uno.name).to eq "garbage"
      post :edit,
           params: {
             id: deck_uno.id,
             deck_id: deck_uno.id,
             name: "peanutbutter"
           }
      expect(deck_uno.reload.name).to eq "peanutbutter"
    end
  end

  describe "#destroy" do
    it "destroys the deck" do
      expect(bob.decks.count).to eq 1
      expect do
        delete :destroy, params: { id: deck_uno.id, deck_id: deck_uno.id }
      end.to change(Deck, :count).by(-1)
      expect(bob.decks.count).to eq 0
    end
  end
end
