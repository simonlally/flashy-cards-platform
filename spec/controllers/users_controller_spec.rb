require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:params) { { email: "portato@aol.com", password: "Pickles123" } }

  describe "#create" do
    context "with valid params" do
      let(:user) { build(:user, email: "portato@aol.com") }

      it "creates a new user" do
        expect(User).to receive(:create).with(params).and_return user
        post :create, params: params
      end

      it "increments the total user count" do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it "returns the correct response body" do
        post :create, params: params
        json_body = JSON.parse(response.body)
        expect(json_body).to eq(
          {
            "status" => "ok!",
            "email" => user.email,
            "token" => json_body["token"]
          }
        )
      end
    end

    it "returns an error if we dont have correct args" do
      post :create, params: {}
      json_body = JSON.parse(response.body)
      expect(json_body["error"]).to eq(
        "bruh send real params, email and a username"
      )
      expect(json_body["status"]).to eq(400)
    end

    context "the email already exists" do
      let!(:user) { create(:user, email: "portato@aol.com") }
      it "returns an error" do
        post :create, params: params

        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq(
          "a user already exists with that email"
        )
        expect(json_body["status"]).to eq(400)
      end

      it "does not create a new user" do
        expect(User).to_not receive(:new)
        post :create, params: params
      end

      it "does not change the total user count" do
        expect { post :create, params: params }.to_not change(User, :count)
      end
    end
  end
end
