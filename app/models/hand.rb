class Hand < ApplicationRecord
  has_many :cards
  belongs_to :player
  belongs_to :round

  def straight?
    cards.order(:value).each_cons(2).all? {|a, b| b.value == a.value + 1 }
  end

  def flush?
    cards[1..-1].all? { |card| card.suit == cards[0].suit }
  end

  def highest_duplicates
    cards.map(&:value).tally.values.max
  end
end
