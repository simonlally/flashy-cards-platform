# == Schema Information
#
# Table name: flash_cards
#
#  id         :bigint           not null, primary key
#  answer     :string
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deck_id    :integer
#
class FlashCard < ApplicationRecord
  belongs_to :deck
end
