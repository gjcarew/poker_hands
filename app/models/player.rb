class Player < ApplicationRecord
  has_many :hands
  has_many :rounds, through: :hands
end
