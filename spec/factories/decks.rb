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
FactoryBot.define do
  factory :deck do
    name { 'my best pokemon deck' }
    label { 'pokemon' }
    user_id { create(:user).id }

    trait :with_flash_cards do
      after(:create) do |deck|
        create_list(:flash_card, 5, deck_id: deck.id)
      end
    end
  end
end
