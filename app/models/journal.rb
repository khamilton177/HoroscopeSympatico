class Journal < ApplicationRecord
  belongs_to :predict
  belongs_to :user
end
