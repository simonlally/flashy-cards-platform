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
class Deck < ApplicationRecord
  belongs_to :user
  has_many :flash_cards, dependent: :destroy
end
