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
    name { "MyString" }
    label { "MyString" }
    user_id { 1 }
  end
end
