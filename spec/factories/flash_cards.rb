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
FactoryBot.define do
  factory :flash_card do
    question { 'MyString' }
    answer { 'MyString' }
    deck_id { 1 }
  end
end
