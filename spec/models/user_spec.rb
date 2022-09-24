# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if the email is not unique' do
    user.save
    user2 = build(:user, email: user.email)
    expect(user2).to_not be_valid
  end

  it 'is not valid if the username is not unique' do
    user.save
    user2 = build(:user, username: user.username)
    expect(user2).to_not be_valid
  end

  it 'is not valid if the password is less than 6 characters' do
    user.password = '12345'
    expect(user).to_not be_valid
  end
end
