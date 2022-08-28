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
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  has_many :decks, dependent: :destroy

  def generate_jwt
    JWT.encode({ id: id, exp: 7.days.from_now.to_i }, ENV["JWT_SECRET_KEY"])
  end
end
