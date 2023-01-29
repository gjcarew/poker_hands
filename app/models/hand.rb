class Hand < ApplicationRecord
  has_many :cards
  belongs_to :player
  belongs_to :round
end
