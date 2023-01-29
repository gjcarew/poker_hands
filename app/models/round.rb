class Round < ApplicationRecord
  has_many :hands
  has_many :players, through: :hands

  def find_winner
    hands.map do |hand|
      # high card hand.cards.max_by { |card| card.value }
      # pair hand.cards.
      # straight hand.cards.order(:value).each_cons(2).all? {|a, b| b == a + 1 }
  end

  def 
end
