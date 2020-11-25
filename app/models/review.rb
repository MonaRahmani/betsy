class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true, numericality: {only_integer: true}, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :name, presence: true
end
