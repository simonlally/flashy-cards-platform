require "rails_helper"

RSpec.describe FlashCardsController, type: :controller do
  let!(:user) { create(:user) }
  let(:current_user) { user }
  let!(:deck) { create(:deck, user: user, name: "sprinkles") }

  it "returns an error if unauthenticated" do
    post :create, params: { deck_id: deck.id }
    expect(JSON.parse(response.body)).to eq(
      { "status" => "failed", "error" => "not authenticated" }
    )
  end

  describe "#create" do
    before do
      allow_any_instance_of(FlashCardsController).to receive(:current_user) {
        current_user
      }
    end
    it "creates a new flash card" do
      expect {
        post :create,
             params: {
               deck_id: deck.id,
               question: "hi",
               answer: "bye"
             }
      }.to change(FlashCard, :count).by(1)
    end
  end

  describe "#edit" do
    before do
      allow_any_instance_of(FlashCardsController).to receive(:current_user) {
        current_user
      }
    end

    it "updates the card" do
      card = FlashCard.create(deck: deck, question: "sup", answer: "not much")
      expect(card.question).to eq "sup"
      expect(card.answer).to eq "not much"
      post :edit,
           params: {
             deck_id: deck.id,
             card_id: card.id,
             question: "what animal goes meow?",
             answer: "cat"
           }
      c = card.reload
      expect(c.question).to eq "what animal goes meow?"
      expect(c.answer).to eq "cat"
      expect(JSON.parse(response.body)["status"]).to eq("sucess")
    end
  end
end
