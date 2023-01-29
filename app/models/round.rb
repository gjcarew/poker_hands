class Round < ApplicationRecord
  has_many :hands
  has_many :players, through: :hands

  def find_winner
    hands.map do |hand|
      # high card hand.cards.max_by { |card| card.value }

      # straight hand.cards.order(:value).each_cons(2).all? {|a, b| b == a + 1 }
  end

  def straight?
    cards.order(:value).each_cons(2).all? {|a, b| b.value == a.value + 1 }
  end

  def flush?
    cards[1..-1].all? { |card| card.suit == cards[0].suit }
  end
end
