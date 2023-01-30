class Round < ApplicationRecord
  has_many :hands
  has_many :players, through: :hands

  def find_winner

  end

  def straight?
    cards.order(:value).each_cons(2).all? {|a, b| b.value == a.value + 1 }
  end

  def flush?
    cards[1..-1].all? { |card| card.suit == cards[0].suit }
  end
end
