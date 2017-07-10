class Predict < ApplicationRecord
  has_many :journals
  has_many :users, through: :journals
end
