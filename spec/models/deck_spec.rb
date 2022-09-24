# == Schema Information
#
# Table name: decks
#
#  id         :bigint           not null, primary key
#  label      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:deck) { build(:deck) }

  it 'is valid with valid attributes' do
    expect(deck).to be_valid
  end

  it 'is not valid without a user_id' do
    deck.user_id = nil
    expect(deck).to_not be_valid
  end
end
