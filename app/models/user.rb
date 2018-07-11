class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true

  has_many :favorites
  has_many :stock_symbols, through: :favorites
end
