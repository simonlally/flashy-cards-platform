# == Schema Information
#
# Table name: flash_cards
#
#  id         :bigint           not null, primary key
#  answer     :string           not null
#  question   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deck_id    :integer          not null
#
require 'rails_helper'

RSpec.describe FlashCard, type: :model do
  let(:flash_card) { build(:flash_card) }

  it 'is not valid without a deck_id' do
    flash_card.deck_id = nil
    expect(flash_card).to_not be_valid
  end

  it 'is not valid without a question' do
    flash_card.question = nil
    expect(flash_card).to_not be_valid
  end

  it 'is not valid without an answer' do
    flash_card.answer = nil
    expect(flash_card).to_not be_valid
  end
end
