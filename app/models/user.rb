class User < ApplicationRecord
  has_many :products
  validates :username, presence: true
  validates :email, presence: true
end
