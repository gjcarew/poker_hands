class Round < ApplicationRecord
  has_many :hands
  has_many :players, through: :hands
end
