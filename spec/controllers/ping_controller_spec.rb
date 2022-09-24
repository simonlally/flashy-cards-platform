require 'rails_helper'

RSpec.describe PingController, type: :controller do
  let!(:user) { create(:user) }
  let(:current_user) { user }

  it 'returns an error if unauthenticated' do
    get :index
    expect(JSON.parse(response.body)).to eq(
      { 'status' => '200', 'authenticated' => false, 'ping' => 'successful' }
    )
  end

  describe '#index' do
    before do
      allow_any_instance_of(PingController).to receive(:current_user) {
        current_user
      }
    end

    it 'returns the correct response body' do
      get :index
      json_body = JSON.parse(response.body)
      expect(json_body).to eq(
        {
          'status' => 200,
          'authenticated' => true,
          'user_email' => user.email
        }
      )
    end
  end
end
