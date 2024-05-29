class Beehive < ApplicationRecord
  validates :name, presence: true, length: { minimum: 6 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
end
