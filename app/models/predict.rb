class Predict < ApplicationRecord
  has_one :zodiac
  has_many :journals
  # has_many :users, through: :journals

end
