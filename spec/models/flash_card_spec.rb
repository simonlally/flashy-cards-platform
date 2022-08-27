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
require 'rails_helper'

RSpec.describe FlashCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
